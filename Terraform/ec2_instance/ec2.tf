provider "aws" {
  region = "us-east-1"
}

variable "isTest" {
  type    = bool
  default = false
}


locals {
  common_tags = {
    Owner       = "Anuj Dube"
    service     = "frontend"
    createdTime = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
  }
}

data "aws_ami" "app_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}


resource "aws_instance" "myec2_1" {
  ami           = data.aws_ami.app_ami.id
  instance_type = "t2.micro"
  count         = var.isTest == true ? 1 : 0
  tags          = local.common_tags
}

resource "aws_instance" "myec2_2" {
  ami           = data.aws_ami.app_ami.id
  instance_type = "t2.nano"
  count         = var.isTest == false ? 1 : 0
  tags          = local.common_tags
}