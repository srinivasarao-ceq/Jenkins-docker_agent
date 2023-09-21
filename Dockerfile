# Stage 1: Build stage
FROM ubuntu:latest as builder

# Install necessary tools and dependencies
RUN apt-get update && apt-get install -y curl unzip

# Download and install AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip -o awscliv2.zip && \
    ./aws/install

# Stage 2: Final image
FROM ubuntu:latest

# Install additional tools and dependencies
RUN apt-get update && apt-get install -y gnupg software-properties-common wget

# Import HashiCorp GPG key
RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint

# Add HashiCorp repository
RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list

# Update package repository and install Terraform
RUN apt-get update && apt-get install -y terraform

# Cleanup unnecessary files and caches
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy AWS CLI v2 from the builder stage to the final image
COPY --from=builder /usr/local/aws-cli /usr/local/aws-cli

# Add the AWS CLI executable to the PATH
ENV PATH="/usr/local/aws-cli/bin:${PATH}"

# You can optionally set other environment variables or configure AWS CLI here

# Default command (can be overridden when running the container)
CMD ["bash"]
