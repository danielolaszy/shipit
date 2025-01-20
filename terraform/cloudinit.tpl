#!/bin/bash
# Update the system
sudo yum update -y

# Install dependencies
sudo yum install -y yum-utils docker

sudo usermod -aG docker $USER

# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Authenticate Docker to ECR
aws ecr get-login-password --region ${aws_region} | sudo docker login --username AWS --password-stdin ${aws_account_id}.dkr.ecr.${aws_region}.amazonaws.com

# Test Docker installation
sudo docker pull ${aws_account_id}.dkr.ecr.${aws_region}.amazonaws.com/${aws_ecr_repository_name}
sudo docker run --restart=always -d -p ${port}:8080 --name ${aws_ecr_repository_name} ${aws_account_id}.dkr.ecr.${aws_region}.amazonaws.com/${aws_ecr_repository_name}:${image_tag}