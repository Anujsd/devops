provider "aws" {
  region     = "us-east-1"
}

resource "aws_instance" "myec2" {
   ami = "ami-0e9107ed11be76fde"
   instance_type = lookup(var.instance_type,terraform.workspace)
}

variable "instance_type" {
    type = map
    default = {
        default = "t2.nano"
        dev     = "t2.micro"
        prod     = "t2.large"
    }
}

/*
terraform workspace list
terraform workspace new dev
terraform workspace new prod


*/