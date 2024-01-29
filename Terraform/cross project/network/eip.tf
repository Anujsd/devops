provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "anujsd-terraform-backend"
    key    = "network/eip.tfstate"
    region = "us-east-1"
  }
}

resource "aws_eip" "lb" {
  domain = "vpc"
}

output "eip_addr" {
  value = aws_eip.lb.public_ip
}