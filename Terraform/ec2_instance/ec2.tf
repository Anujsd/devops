provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "myec2" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  key_name = "github-pair"
  user_data = <<-EOF
    #!/bin/bash
    
    apt-get update
    apt-get upgrade -y

    # Add Docker's official GPG key:
    sudo apt-get install -y ca-certificates curl gnupg
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg

    # Add the repository to Apt sources:
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update

    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    sudo groupadd docker

    sudo usermod -aG docker ubuntu

    sudo reboot
  EOF

  tags          = {
    Name = "cicdInstance"
  }
}

output "public_ip" {
  value = aws_instance.myec2.public_ip
}

output "public_dns" {
  value = aws_instance.myec2.public_dns
}


/*
# variable "isTest" {
#   type    = bool
#   default = false
# }


data "aws_ami" "app_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}


# # Create 2 identical ec2 intances

# resource "aws_instance" "ec2" {
#     ami = data.aws_ami.app_ami.id
#     for_each = {
#       inst1 = "t2.micro"
#       inst2 = "t2.nano"
#     }  
#     instance_type = each.value
#     tags = {
#       Name = each.key
#     }
# }

# output "ec2Data" {
#   value = aws_instance.ec2[*]
# }

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



resource "aws_instance" "myec2_2" {
  ami           = data.aws_ami.app_ami.id
  instance_type = "t2.micro"
  # count         = var.isTest == false ? 1 : 0
}

# output "ec2_1_id" {
#   value = aws_instance.myec2_1.id
# }

output "ec2_2_id" {
  value = aws_instance.myec2_2.id
}
*/