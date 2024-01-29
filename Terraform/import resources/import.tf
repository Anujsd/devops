provider "aws" {
  region = "us-east-1"
}

import {
  to = aws_security_group.mysg
  id = "sg-01ed01309d6123f3d"
}