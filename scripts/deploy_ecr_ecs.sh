#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 6 ]; then
  echo "Uso: $0 <aws_region> <aws_account_id> <ecr_repo_name> <image_tag> <ecs_cluster_name> <ecs_service_name>"
  exit 1
fi

AWS_REGION="$1"
AWS_ACCOUNT_ID="$2"
ECR_REPO_NAME="$3"
IMAGE_TAG="$4"
ECS_CLUSTER_NAME="$5"
ECS_SERVICE_NAME="$6"

ECR_URI="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO_NAME}"

aws ecr get-login-password --region "$AWS_REGION" | docker login --username AWS --password-stdin "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"

docker build -t "${ECR_REPO_NAME}:${IMAGE_TAG}" app/
docker tag "${ECR_REPO_NAME}:${IMAGE_TAG}" "${ECR_URI}:${IMAGE_TAG}"
docker tag "${ECR_REPO_NAME}:${IMAGE_TAG}" "${ECR_URI}:latest"

docker push "${ECR_URI}:${IMAGE_TAG}"
docker push "${ECR_URI}:latest"

aws ecs update-service \
  --cluster "$ECS_CLUSTER_NAME" \
  --service "$ECS_SERVICE_NAME" \
  --force-new-deployment \
  --region "$AWS_REGION"

echo "Deploy disparado com sucesso: ${ECR_URI}:${IMAGE_TAG}"
