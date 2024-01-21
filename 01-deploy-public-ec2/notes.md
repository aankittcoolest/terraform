
## Steps

```bash
export TF_VAR_key_name=ec2-vpn
export TF_VAR_azs='["ap-south-1a", "ap-south-1b", "ap-south-1c"]'
export TF_VAR_ami_id=ami-0d980397a6e8935cd
export TF_VAR_user_data='#!/bin/bash
echo "Hello world"
'
terraform apply -target=module.vpc -auto-approve
terraform apply -target=module.public-subnets -target=module.private-subnets -auto-approve
terraform apply -auto-approve
terraform destroy -auto-approve
```
