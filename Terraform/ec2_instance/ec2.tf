provider "aws" {
  region = "us-east-1"
}

variable "isTest" {
  type    = bool
  default = false
}


data "aws_ami" "app_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}


# Create 2 identical ec2 intances

resource "aws_instance" "ec2" {
    ami = data.aws_ami.app_ami.id
    for_each = {
      inst1 = "t2.micro"
      inst2 = "t2.nano"
    }  
    instance_type = each.value
    tags = {
      Name = each.key
    }
}

output "ec2Data" {
  value = aws_instance.ec2[*]
}

# locals {
#   common_tags = {
#     Owner       = "Anuj Dube"
#     service     = "frontend"
#     createdTime = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
#     Name = data.aws_ami.app_ami.id
#   }
# }

# resource "aws_instance" "myec2_1" {
#   ami           = "ami-0f34c5ae932e6f0e4"
#   instance_type = "t2.micro"
#   # count         = var.isTest == true ? 1 : 0
#   tags          = local.common_tags

#   lifecycle {
#     # create_before_destroy = true
#     prevent_destroy = true
#     ignore_changes = [tags]
#   }
# }



# resource "aws_instance" "myec2_2" {
#   ami           = data.aws_ami.app_ami.id
#   instance_type = "t2.micro"
#   # count         = var.isTest == false ? 1 : 0
#   tags          = local.common_tags
# }

# output "ec2_1_id" {
#   value = aws_instance.myec2_1.id
# }

# output "ec2_2_id" {
#   value = aws_instance.myec2_2.id
# }