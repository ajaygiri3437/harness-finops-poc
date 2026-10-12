terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
    }
  }
}

provider "null" {}

resource "null_resource" "ec2_reboot" {
  provisioner "local-exec" {
    command = "aws ec2 reboot-instances --instance-ids i-045e3d3e8f3f61587 --region us-east-1"
  }
}