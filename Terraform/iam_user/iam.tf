terraform {
  required_version = "> 0.11"
  required_providers {
    aws = "~> 2.0"
  }
}

provider "aws" {
  region = "us-east-1"
}

variable "elb_names" {
  type = list
  default = ["dev-loadbalancer", "stage-loadbalanacer","prod-loadbalancer"]
}

resource "aws_iam_user" "lb" {
  name = var.elb_names[count.index]
  count = 3
  path = "/"
}

# output "allvalues" {
#   value = aws_iam_user.lb[*]
# }

output "arns" {
  value = aws_iam_user.lb[*].arn
}

output "zipmap" {
  value = zipmap(aws_iam_user.lb[*].name, aws_iam_user.lb[*].arn)
}