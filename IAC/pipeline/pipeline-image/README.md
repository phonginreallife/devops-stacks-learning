# 🚀 Pipeline Image Scripts

This directory contains scripts for building a Docker image and uploading it to Amazon ECR.

## 📋 Prerequisites

- AWS CLI installed and configured. 🛠️
- Docker Engine installed. 🐳
- Docker buildx installed. 🏗️

## 🚀 Usage

1. Navigate to the `/pipeline-image` directory: 🗂️

    ```bash
    cd /repository-configuration/pipeline-image
    ```

2. Update the `parameters.sh` file if needed. This file contains the configuration for building and uploading the Docker image. 📝

3. Run the `build.sh` script: 🏃‍♂️

    ```bash
    ./build.sh
    ```
    This script will build the Docker image using Docker buildx. <br>
    If AWS is not configured or Docker buildx is not installed, the script will exit and prompt you to configure AWS. ⚠️

4. When prompted, enter `N` to keep image at local for testing before upload to ECR

    ```bash
    Upload ${AWS_ECR_REPO} to docker hub? [y,N]
    N
    ```
    Run container from the image:
    ```
    docker run -it --name appsec-image 123831926968.dkr.ecr.us-west-2.amazonaws.com/appsec-image:0.1.2 /bin/sh
    ```
    Inside container, verify version of new tool or feature:
    ```
    /pipeline # aws --version
    aws-cli/2.13.25 Python/3.11.6 Linux/5.15.123.1-microsoft-standard-WSL2 source/x86_64.alpine.3 prompt/off

    /pipeline # eksctl version
    0.167.0

    /pipeline # helm version
    version.BuildInfo{Version:"v3.13.3", GitCommit:"c8b948945e52abba22ff885446a1486cb5fd3474", GitTreeState:"clean", GoVersion:"go1.20.11"}

    /pipeline # kubectl version --client
    WARNING: This version information is deprecated and will be replaced with the output from kubectl version --short.  Use --output=yaml|json to get the full version.
    Client Version: version.Info{Major:"1", Minor:"27", GitVersion:"v1.27.9", GitCommit:"d15213f69952c79b317e635abff6ff4ec81475f8", GitTreeState:"clean", BuildDate:"2023-12-19T13:41:13Z", GoVersion:"go1.20.12", Compiler:"gc", Platform:"linux/amd64"}
    Kustomize Version: v5.0.1

    /pipeline # terraform --version
    Terraform v1.6.6
    on linux_amd64
    ```

5. Run `./build.sh` again, when prompted, enter `y` to upload the Docker image to ECR: 🚀

    ```bash
    ./build.sh
    ...
    Upload ${AWS_ECR_REPO} to docker hub? [y,N]
    y
    ```
    The script will then upload the Docker image to the ECR repository specified in parameters.sh. 📤

## 🚧 Troubleshooting

If you encounter any issues, please check the following:

- Ensure AWS is configured correctly. 🛠️

- Ensure the parameters in `parameters.sh` are correct. 📝

- Ensure Docker is installed and running. 🐳

- If docker push is getting stuck at pushing one layer: 🚧

    ```bash
    cd1854d95a4e: Layer already exists 
    84ac0f7c8c30: Layer already exists 
    56fbebd1aa9e: Layer already exists 
    73591222729a: Layer already exists 
    58a2f231d4c4: Layer already exists 
    d198236e2237: Pushin [========>           ]  79.46MB/473MB
    013ab1f78f06: Layer already exists 
    5af4f8f59b76: Layer already exists 
    ```

    Let restart docker on your local 😊.

    ```bash
    sudo systemctl restart docker
    ```