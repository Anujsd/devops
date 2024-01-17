# provider defined in providers.tf file


# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "myec2" {
    ami = "ami-00c39f71452c08778"
    instance_type = "t2.micro"
    tags = {
        Name = "terrform-created-it" # name doesn't work
    }
}
