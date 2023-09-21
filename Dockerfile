# Stage 1: Build stage
FROM ubuntu:latest as builder

# Install necessary tools and dependencies
RUN apt-get update && apt-get install -y curl unzip


RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip -o awscliv2.zip && \
    ./aws/install \
    apt-get update && apt-get install -y gnupg software-properties-common wget \
    wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list \
    apt-get update && apt-get install -y terraform \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \

# Add the AWS CLI executable to the PATH
ENV PATH="/usr/local/aws-cli/bin:${PATH}"

# You can optionally set other environment variables or configure AWS CLI here

# Default command (can be overridden when running the container)
CMD ["bash"]
