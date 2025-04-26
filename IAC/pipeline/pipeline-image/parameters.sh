#!/usr/bin/env bash

# parameters.sh
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  echo "This script is meant to be sourced, not run directly."
  exit 1
fi

# This is a multi-line comment
cat <<EOF >/dev/null
Use the format MAJOR.MINOR.PATCH (e.g., 1.2.3) for image tags.
Each component has a specific meaning:
    * MAJOR: Increment for backward-incompatible changes.
    * MINOR: Increment for new features that maintain backward compatibility.
    * PATCH: Increment for bug fixes that don't introduce new features.
Additionally, the following tags are reserved:
    * Pre-release tags (e.g., 1.2.3-alpha.1): For testing and development.
    * Build metadata (e.g., 1.2.3+build.1234): For additional information.
    
Refer https://semver.org/
EOF

TAG="0.3.3" # This is the tag for the docker/ecr image 0.3.2 newssh key for appsec.sre@opswat.com
REGION="us-west-2" # This is the AWS region that hosts the ECR repository
AWS_ACCOUNT="123831926968" # This is the AWS account that hosts the ECR repository
AWS_ECR_REPO="${AWS_ACCOUNT}.dkr.ecr.${REGION}.amazonaws.com/appsec-image" # This is the ECR repository name

# https://hub.docker.com/_/alpine/tags
ALPINE_VER="3.9-alpine" 

# https://github.com/eksctl-io/eksctl/releases
EKSCTL_VER="0.167.0"

# https://github.com/helm/helm/releases
HELM_VER="3.13.3"

# https://github.com/kubernetes/kubernetes/releases
# Must use a kubectl version that is within one minor version difference of our cluster
KUBECTL_VER="1.27.9" 

# https://github.com/hashicorp/terraform/releases
TERRAFORM_VER="1.6.6"