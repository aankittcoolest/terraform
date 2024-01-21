
## Steps

```bash
terraform apply -target=module.vpc -auto-approve
terraform apply -target=module.public-subnets -target=module.private-subnets -auto-approve
terraform apply -auto-approve
terraform destroy -auto-approve
```