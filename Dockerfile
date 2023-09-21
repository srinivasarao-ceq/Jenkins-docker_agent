# Use the official Ubuntu image as the base image
FROM ubuntu:latest

# Set environment variables for AWS CLI
# ENV AWS_ACCESS_KEY_ID=""
# ENV AWS_SECRET_ACCESS_KEY=""
# ENV AWS_DEFAULT_REGION=""

# Update package list and install dependencies
RUN apt-get update -y \
    && apt-get install -y \
       unzip \
       curl \
       python3-pip

# Install AWS CLI
RUN pip3 install awscli

# Install Terraform
RUN curl -LO https://releases.hashicorp.com/terraform/0.15.5/terraform_0.15.5_linux_amd64.zip \
    && unzip terraform_0.15.5_linux_amd64.zip -d /usr/local/bin/ \
    && rm terraform_0.15.5_linux_amd64.zip

# Clean up
RUN apt-get clean

# Default command (optional)
# CMD ["bash"]
