#!/bin/bash

# Docker login
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

# Buildxのセットアップ
docker buildx create --use

# マルチプラットフォームビルド
docker buildx build --platform linux/amd64,linux/arm64 -t $REPO_URL:$CONTAINER_NAME-latest -f ../modules/fargate/fluentbit/Dockerfile ../modules/fargate/fluentbit --push

echo "Dockerイメージのマルチプラットフォームビルドとプッシュが成功しました。"

