#!/bin/bash

# SSMパラメータの名前
SSM_PARAMETER_NAME="REACT_APP_API_URL"
# 出力ファイルのパス
OUTPUT_FILE=".env"

# SSMからパラメータの値を取得
PARAMETER_VALUE=$(aws ssm get-parameter --name "$SSM_PARAMETER_NAME" --query "Parameter.Value" --output text)

# 取得した値を.envファイルの特定の形式で書き込み
echo "REACT_APP_API_URL=$PARAMETER_VALUE" > "$OUTPUT_FILE"
