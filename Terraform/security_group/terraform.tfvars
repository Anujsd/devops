vpn_ip = "1.1.1.1/32"

# variables in terraform.tfvars has 2nd highest pririty

# more than environment variables

# but less than variables set using commands 
# terraform plan -var="instancetype=t2.small"
# terraform plan -var-file="custom.tfvars"