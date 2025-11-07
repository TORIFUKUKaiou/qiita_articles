---
title: EC2の起動停止でパブリックIPが変わる件をLambda + Route 53で自動解決する
tags:
  - AWS
  - 猪木
  - 闘魂
  - AdventCalendar2025
  - AIではなく人間が書いてます
private: false
updated_at: '2025-11-06T22:52:25+09:00'
id: b2cd2bbb01f5efddf767
organization_url_name: null
slide: false
ignorePublish: false
---
> 「[API Gateway](https://aws.amazon.com/jp/api-gateway/)でいいんでないの？」
> ーー その通りです。

## はじめに

EC2インスタンスにMock APIを作りました。
一応、HTTPSにしておきたいです。Let's Encryptで手動でポチポチ取得しました。
Route 53で、AレコードでEC2インスタンスのパブリックIPv4を登録しています。
使いたいのは日中だけです。
Elastic IPは取得したくないです。
わがままです。

Event Bridgeの定期実行で、`{"action": "stop"}`や`{"action": "start"}`や送りこむとして、再起動するたびにパブリックIPv4がかわるので、Route 53のAレコードを更新したいです。

## はい、できました

[Amazon Q Developer CLI](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/command-line.html)がまたたく間に作ってくれました。本当にまばたき一回するか二回するか三回するかくらいで作ってくれました。

[get_waiter](https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2/client/get_waiter.html)とか、まさにこの用途にぴったりのメソッドを利用しています。こんなの知るわけないです。知らないとポーリングとか地味にやりそうです。

[Amazon Q Developer CLI](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/command-line.html)に相談して本当によかったです。


```python:lambda_function.py
import os
import json
import time
import logging
from datetime import datetime, timezone

import boto3
from botocore.config import Config
from botocore.exceptions import ClientError

# ログ
logger = logging.getLogger()
logger.setLevel(logging.INFO)

# boto3クライアント（再利用）
cfg = Config(retries={"max_attempts": 10, "mode": "standard"})
ec2 = boto3.client("ec2", config=cfg)
route53 = boto3.client("route53", config=cfg)

# 環境変数
INSTANCE_ID = os.environ["INSTANCE_ID"]
HOSTED_ZONE_ID = os.environ["HOSTED_ZONE_ID"]
DOMAIN_NAME = os.environ["DOMAIN_NAME"]  # 例: "app.example.com."

def _utc_now_iso():
    return datetime.now(timezone.utc).isoformat()

def _get_instance(instance_id: str):
    r = ec2.describe_instances(InstanceIds=[instance_id])
    res = r.get("Reservations", [])
    if not res or not res[0].get("Instances"):
        raise RuntimeError(f"Instance not found: {instance_id}")
    return res[0]["Instances"][0]

def _get_state_name(instance_id: str) -> str:
    inst = _get_instance(instance_id)
    return inst["State"]["Name"]  # pending | running | stopping | stopped | shutting-down | terminated

def _wait_public_ip(instance_id: str, timeout=180, interval=3) -> str:
    deadline = time.time() + timeout
    while time.time() < deadline:
        inst = _get_instance(instance_id)
        ip = inst.get("PublicIpAddress")
        if ip:
            return ip
        time.sleep(interval)
    raise TimeoutError("Public IP not assigned within timeout")

def _change_rrset(action: str, hosted_zone_id: str, domain_name: str, ip: str | None, ttl: int = 60) -> str:
    if action in ("UPSERT", "CREATE"):
        rrset = {
            "Name": domain_name,
            "Type": "A",
            "TTL": ttl,
            "ResourceRecords": [{"Value": ip}],
        }
    elif action == "DELETE":
        # 事前に現行値を取得して正確にDELETEを実行
        current = route53.list_resource_record_sets(HostedZoneId=hosted_zone_id, StartRecordName=domain_name, StartRecordType="A", MaxItems="1")
        records = current.get("ResourceRecordSets", [])
        if not records or records[0]["Name"].rstrip(".") != domain_name.rstrip(".") or records[0]["Type"] != "A":
            logger.info("A record not found. Skip DELETE.")
            return "noop"
        rrset = records[0]
    else:
        raise ValueError(f"Unsupported action for rrset: {action}")

    change_batch = {
        "Comment": f"Lambda EC2 DNS sync - {action} - { _utc_now_iso() }",
        "Changes": [{"Action": action, "ResourceRecordSet": rrset}],
    }
    resp = route53.change_resource_record_sets(HostedZoneId=hosted_zone_id, ChangeBatch=change_batch)
    return resp["ChangeInfo"]["Id"]

def start_instance_and_update_dns(instance_id: str, hosted_zone_id: str, domain_name: str):
    state = _get_state_name(instance_id)
    if state == "running":
        logger.info("Already running. Skipped start.")
    elif state in ("stopped",):
        ec2.start_instances(InstanceIds=[instance_id])
        ec2.get_waiter("instance_running").wait(InstanceIds=[instance_id])
        try:
            ec2.get_waiter("instance_status_ok").wait(InstanceIds=[instance_id])
        except Exception:
            logger.info("status_ok wait skipped")

    public_ip = _wait_public_ip(instance_id)
    change_id = _change_rrset("UPSERT", hosted_zone_id, domain_name, public_ip, ttl=60)
    try:
        route53.get_waiter("resource_record_sets_changed").wait(Id=change_id)
    except Exception:
        logger.info("Route53 propagation wait skipped")

    return {"action": "start", "instance_id": instance_id, "public_ip": public_ip, "domain": domain_name}

def stop_instance_and_delete_dns(instance_id: str, hosted_zone_id: str, domain_name: str):
    state = _get_state_name(instance_id)
    if state == "stopped":
        logger.info("Already stopped. Skipped stop.")
    elif state in ("running",):
        ec2.stop_instances(InstanceIds=[instance_id])
        ec2.get_waiter("instance_stopped").wait(InstanceIds=[instance_id])

    # 誤誘導を避けるためAレコードを削除
    try:
        change_id = _change_rrset("DELETE", hosted_zone_id, domain_name, ip=None)
        if change_id != "noop":
            route53.get_waiter("resource_record_sets_changed").wait(Id=change_id)
    except ClientError as e:
        # レコード非存在でも続行
        logger.info(f"DNS delete skipped: {e}")

    return {"action": "stop", "instance_id": instance_id, "domain": domain_name}

def _resolve_action(event: dict) -> str:
    # body / query / direct の順で柔軟に拾う
    if isinstance(event.get("body"), str):
        try:
            body = json.loads(event["body"])
            if "action" in body:
                return body["action"]
        except Exception:
            pass
    qs = event.get("queryStringParameters") or {}
    if "action" in qs:
        return qs["action"]
    if "action" in event:
        return event["action"]
    return "unknown"

def lambda_handler(event, context):
    ts = _utc_now_iso()
    try:
        action = _resolve_action(event)
        logger.info(f"Start: {action} at {ts}")

        if action == "start":
            result = start_instance_and_update_dns(INSTANCE_ID, HOSTED_ZONE_ID, DOMAIN_NAME)
        elif action == "stop":
            result = stop_instance_and_delete_dns(INSTANCE_ID, HOSTED_ZONE_ID, DOMAIN_NAME)
        else:
            raise ValueError(f"Invalid action: {action}")

        logger.info(f"Done: {result}")
        return {
            "statusCode": 200,
            "body": json.dumps({"message": f"{action} completed", "result": result, "timestamp": ts}, ensure_ascii=False),
        }
    except Exception as e:
        logger.exception("Error")
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e), "timestamp": ts}, ensure_ascii=False),
        }

```

## さいごに

[Amazon Q Developer CLI](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/command-line.html)最高です。私は愛用しています。

この記事は、生成AIの好プレーだと思います。

それで、そもそも論で言うと、冒頭に書いたように、「[API Gateway](https://aws.amazon.com/jp/api-gateway/)でいいんでないの？」ーー「はい！、[そのとーりですぅ!](https://ja.wikipedia.org/wiki/%E3%81%9F%E3%81%91%E3%81%97%E3%83%BB%E3%81%95%E3%82%93%E3%81%BE%E4%B8%96%E7%B4%80%E6%9C%AB%E7%89%B9%E5%88%A5%E7%95%AA%E7%B5%84!!_%E4%B8%96%E7%95%8C%E8%B6%85%E5%81%89%E4%BA%BA%E4%BC%9D%E8%AA%AC)」

もしかしたら、どなたかのお役に立てるかもしれませんので、惜しげもなく全世界のみなさまへ向けて公開しておきます。
