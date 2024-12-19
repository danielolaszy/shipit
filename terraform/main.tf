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

resource "aws_instance" "shipit" {
  ami                  = var.aws_ami_id
  instance_type        = var.aws_instance_type
  subnet_id            = aws_subnet.shipit_subnet.id
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  security_groups      = [aws_security_group.shipit_security_group.id]

  associate_public_ip_address = true

  # https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html
  user_data = var.cloudinit_script

  tags = {
    Name = var.aws_instance_name
  }
}
