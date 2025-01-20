terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.68"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "ec2" {
  ami                  = var.aws_ami_id
  instance_type        = var.aws_instance_type
  subnet_id            = aws_subnet.shipit_subnet.id
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  security_groups      = [aws_security_group.shipit_security_group.id]

  associate_public_ip_address = true

  user_data = templatefile("cloudinit.tpl", {
    aws_account_id = var.aws_account_id
    aws_region = var.aws_region
    aws_ecr_repository_name = var.aws_ecr_repository_name
    port = var.port
    image_tag = var.image_tag
  })

  tags = {
    Name = var.aws_instance_name
  }
}


resource "aws_ecr_repository" "ecr" {
  name                 = var.aws_ecr_repository_name
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true            # Enable automatic vulnerability scanning
  }
}
