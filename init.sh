#!/bin/bash
set -e

mkdir -p /home/vscode/.config/qiita-cli
cat <<EOF > /home/vscode/.config/qiita-cli/credentials.json
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