# Terraform

Mainly used for creating infrastructure

Learning from https://github.com/zealvora/terraform-beginner-to-advanced-resource

## AWS Configurations

#### Add credentials

```
aws configure
```

#### Check credentials

```
aws ec2 describe-instances
```

## Terraform Commands

### Add aws provider

```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
```

As aws is tier 1 provider if you just do configuration
it will work, no need to define it in terraform block
so you need only below block

```
provider "aws" {
  region = "us-east-1"
}
```

but for tier 2 and 3 providers you need to define provider
inside terraform block.

### Create EC2 instance

```
resource "aws_instance" "ec2" {
    ami = "ami-00c39f71452c08778"
    instance_type = "t2.micro"
}
```

### Use Below commands

```
terraform init

terraform plan

terraform apply
terraform apply -auto-approve

terraform detroy
terraform destroy -auto-approve


terraform detroy --target = aws_instance.ec2
```

### Recreate Resource

```
terraform apply -replace="aws_instance.myec2"
```

### format terraform

```
terraform fmt
```

### validate terraform

```
terraform validate
```

### adding tags

You can set TF_LOG to one of the log levels (in order of decreasing verbosity)

TRACE, DEBUG, INFO, WARN or ERROR to change the verbosity of the logs.

```
setx TF_LOG TRACE
setx TF_LOG DEBUG

setx TF_LOG_PATH C:\temp\crash.log


setx TF_VAR_instancetype t2.large
```
