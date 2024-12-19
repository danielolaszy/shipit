# AWS Variables

variable "aws_region" {
  description = "The AWS region where the resources will be deployed. Default is set to eu-west-2 (London)."
  type        = string
  default     = "eu-west-2" # London
}

variable "aws_availabilty_zone" {
  type        = string
  default     = "a"
}

variable "aws_account_id" {
  description = "The unique identifier for the AWS account where resources will be deployed. Required for IAM policies and ECR references."
  type        = string
  default     = "084828564941"
}

# Free tier:
# In your first year includes 750 hours of t2.micro (or t3.micro in the Regions in which t2.micro is unavailable)
# instance usage on free tier AMIs per month, 750 hours of public IPv4 address usage per month, 30 GiB of EBS storage,
# 2 million IOs, 1 GB of snapshots, and 100 GB of bandwidth to the internet.

variable "aws_instance_type" {
  description = "The type of EC2 instance to use, determining the compute, memory, and networking resources available. Default is t3.micro for cost efficiency."
  type        = string
  default     = "t3.micro" # vCPUs=2 Architecture=x86_64 Memory=1GiB NetworkPerformance=5 Gigabit
}

variable "aws_ami_id" {
  description = "The Amazon Machine Image (AMI) ID used to launch the EC2 instance. Defines the OS and pre-installed software. Default is Amazon Linux 2023 for eu-west-2."
  type        = string
  default     = "ami-0c76bd4bd302b30ec" # Amazon Linux 2023 in eu-west-2
}

variable "aws_instance_name" {
  description = "A human-readable name for the EC2 instance. Used for easy identification in the AWS Console. Default is 'shipit'."
  type        = string
  default     = "shipit"
}

variable "aws_ecr_repository_name" {
  description = "The name of the ECR repository where Docker images will be stored."
  type        = string
  default     = "app/shipit"
}

# GitHub Variables

variable "github_user" {
  description = "The GitHub username or organization under which the repository is hosted."
  type        = string
  default     = "danielolaszy"
}

variable "github_repository" {
  description = "The name of the GitHub repository containing the application code."
  type        = string
  default     = "shipit"
}

variable "cloutinit_script" {
  description = "The cloud-init script used when booting up the EC2 instance in order to install Docker."
  type        = string
  default     = <<-EOF
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
              aws ecr get-login-password --region eu-west-2 | sudo docker login --username AWS --password-stdin 084828564941.dkr.ecr.eu-west-2.amazonaws.com

              # Test Docker installation
              sudo docker pull 084828564941.dkr.ecr.eu-west-2.amazonaws.com/app/shipit
              sudo docker run --restart=always -d -p 8080:8080 --name shipit 084828564941.dkr.ecr.eu-west-2.amazonaws.com/app/shipit:latest
              EOF
}


