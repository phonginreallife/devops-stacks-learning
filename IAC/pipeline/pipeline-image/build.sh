#!/usr/bin/env bash

CWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd ${CWD}

# Source the parameters file
source parameters.sh

# Check if AWS is configured
AWS_CONFIGURED=$(aws configure list)
if [[ -z "${AWS_CONFIGURED}" ]]; then
  echo "AWS is not configured. Please configure it before running this script."
  exit 1
fi

# Check if Docker Buildx is installed
BUILDX_VERSION=$(docker buildx version)
if [[ -z "${BUILDX_VERSION}" ]]; then
  echo "Docker Buildx is not installed. Please install it before running this script. (The legacy builder is deprecated and will be removed in a future release)"
  exit 1
fi

# Build the Docker image
echo "Building docker image: ${AWS_ECR_REPO}:${TAG}"
docker buildx build \
  --build-arg ALPINE_VER=${ALPINE_VER} \
  --build-arg EKSCTL_VER=${EKSCTL_VER} \
  --build-arg HELM_VER=${HELM_VER} \
  --build-arg KUBECTL_VER=${KUBECTL_VER} \
  --build-arg TERRAFORM_VER=${TERRAFORM_VER} \
  --secret id=sshkey,src=argo-workflows \
  --tag ${AWS_ECR_REPO}:${TAG} --file Dockerfile .
    
  
[[ $? != 0 ]] && echo "Build image failed " && exit 1;

# Upload iamge to ECR
echo "Upload ${AWS_ECR_REPO} to docker hub? [y,N]"
read ANSWER
if [[ ${ANSWER} == 'y' ]]; then
  aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${AWS_ECR_REPO}
  docker push ${AWS_ECR_REPO}:${TAG}
  docker logout ${AWS_ECR_REPO}
fi