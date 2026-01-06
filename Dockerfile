# Use Ubuntu base image
FROM ubuntu:22.04

# Install required packages and Terraform
RUN apt-get update && \
    apt-get install -y wget unzip curl && \
    wget https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_linux_amd64.zip && \
    unzip terraform_1.6.6_linux_amd64.zip && \
    mv terraform /usr/local/bin/ && \
    terraform --version

# Set working directory inside container
WORKDIR /terraform
