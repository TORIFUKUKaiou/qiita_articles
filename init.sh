#!/bin/bash
set -e

mkdir -p /home/node/.config/qiita-cli
cat <<EOF > /home/node/.config/qiita-cli/credentials.json
{
  "default": "qiita",
  "credentials": [
    {
      "name": "qiita",
      "accessToken": "${QIITA_TOKEN}"
    }
  ]
}
EOF