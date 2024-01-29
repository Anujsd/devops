resource "aws_instance" "myec2" {
   ami = "ami-0e9107ed11be76fde"
   instance_type = var.instance_type
}

variable "instance_type" {
  default = "t2.micro"
}