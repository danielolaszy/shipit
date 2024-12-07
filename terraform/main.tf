terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.68" # Using version 5.68 as higher versions were causing issues
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "shipit" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}
