provider "aws" {
  region = "us-east-1"
}

module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "cluster"
  instance_count         = 1

  ami                    = "ami-0e9107ed11be76fde"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-4dbfb206"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}


# module "ec2" {
#   source = "C:/Users/admin/Desktop/notes/devops/devops/Terraform/modules/ec2-using-module/module/"
# }