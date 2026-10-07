terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "finops_poc" {
  ami           = "ami-0d27e0fb3bac4d724"
  instance_type = "t3.small"

  tags = {
    Name        = "Harness-FinOps-POC"
    Environment = "POC"
    Purpose     = "EC2-Rightsizing"
  }
}