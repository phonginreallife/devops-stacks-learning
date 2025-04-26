ARG ALPINE_VER

FROM python:${ALPINE_VER}


LABEL maintainer="phongle-SRE"

# Install necessary packages
RUN apk add --no-cache \
    curl \
    python3 \
    py3-pip \
    groff \
    less \
    mailcap \
    unzip \
    tar \
    git \
    # https://pkgs.alpinelinux.org/packages?name=aws-cli
    aws-cli \
    openssh-client

# Install eksctl
ARG EKSCTL_VER
RUN curl -fLO https://github.com/eksctl-io/eksctl/releases/download/v${EKSCTL_VER}/eksctl_Linux_amd64.tar.gz \
    && tar -xzf eksctl_Linux_amd64.tar.gz -C /tmp \
    && rm eksctl_Linux_amd64.tar.gz \
    && mv /tmp/eksctl /usr/local/bin

# Install helm
ARG HELM_VER
RUN curl -fLO https://get.helm.sh/helm-v${HELM_VER}-linux-amd64.tar.gz \
    && tar -zxvf helm-v${HELM_VER}-linux-amd64.tar.gz -C /tmp \
    && rm helm-v${HELM_VER}-linux-amd64.tar.gz \
    && mv /tmp/linux-amd64/helm /usr/local/bin/helm

# Install kubectl
ARG KUBECTL_VER
RUN curl -fLO https://dl.k8s.io/release/v${KUBECTL_VER}/bin/linux/amd64/kubectl\
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl

# Install terraform
ARG TERRAFORM_VER
RUN curl -fLO https://releases.hashicorp.com/terraform/${TERRAFORM_VER}/terraform_${TERRAFORM_VER}_linux_amd64.zip \
    && unzip terraform_${TERRAFORM_VER}_linux_amd64.zip \
    && mv terraform /usr/local/bin/ \
    && rm terraform_${TERRAFORM_VER}_linux_amd64.zip

# #Add Bitbucket SSH key
# RUN mkdir -p /root/.ssh
# # syntax=docker/dockerfile:1.0.0-experimental
# RUN --mount=type=secret,id=sshkey \
#     cp /run/secrets/sshkey /root/.ssh/argo-workflows && \
#     chmod 600 /root/.ssh/argo-workflows
# RUN ssh-keyscan bitbucket.org >> /root/.ssh/known_hosts \
#     ssh-add ~/.ssh/argo-workflows
# RUN cat >~/.ssh/config <<EOF
# Host bitbucket.org
# AddKeysToAgent yes
# IdentityFile ~/.ssh/argo-workflows
# EOF

#Python dependencies
RUN mkdir pipeline
COPY ./test-file.txt /pipeline
COPY ./requirements.txt /pipeline
RUN pip3 install --upgrade pip

# Set work directory
WORKDIR /pipeline
RUN pip3 install -r requirements.txt