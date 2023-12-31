#!/bin/bash

# Docker login
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

# Build image
docker build -t $CONTAINER_NAME -f ../modules/fargate/fluentbit/Dockerfile ../modules/fargate/fluentbit

# Tag
docker tag $CONTAINER_NAME:latest $REPO_URL:$CONTAINER_NAME-latest

# Push image
docker push $REPO_URL:$CONTAINER_NAME-latest
