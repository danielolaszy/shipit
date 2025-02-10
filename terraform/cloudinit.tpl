#!/bin/bash
# Update the system
sudo yum update -y
sudo yum install -y httpd mod_ssl yum-utils docker
sudo systemctl start httpd
sudo systemctl enable httpd

sudo usermod -aG docker $USER

# AWS Instance Metadata Service Version 2 (IMDBSv2) Session Token
TOKEN=$(curl -sX PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

# Fetch public host name from AWS Instance Metadata Service (IMDS)
PUBLIC_DNS=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/public-hostname)

# Generate a self-signed SSL certificate using the instance's public DNS
sudo mkdir -p /etc/pki/tls/certs
sudo mkdir -p /etc/pki/tls/private
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-keyout /etc/pki/tls/private/selfsigned.key \
-out /etc/pki/tls/certs/selfsigned.crt \
-subj "/CN=$PUBLIC_DNS"


# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Authenticate Docker to ECR
aws ecr get-login-password --region ${aws_region} | sudo docker login --username AWS --password-stdin ${aws_account_id}.dkr.ecr.${aws_region}.amazonaws.com

# Test Docker installation
sudo docker pull ${aws_account_id}.dkr.ecr.${aws_region}.amazonaws.com/${aws_ecr_repository_name}
sudo docker run --restart=always -d -p 8080:8080 --name ${aws_ecr_repository_name} ${aws_account_id}.dkr.ecr.${aws_region}.amazonaws.com/${aws_ecr_repository_name}:${image_tag}