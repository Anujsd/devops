provider "aws" {
  region = "us-east-1"
}

module "sgmodule" {
  source = "C:/Users/admin/Desktop/notes/devops/devops/Terraform/modules/security-group/module/"
}

output "sg_id_output" {
  value = module.sgmodule.sg_id
}