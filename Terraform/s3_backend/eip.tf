terraform {
  backend "s3" {
    bucket = "terraform-tf-asd"
    key="network/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-state-locking"
  }
}
provider "aws" {
  region = "us-east-1"
}

resource "aws_eip" "eip" {
  domain = "vpc"
}