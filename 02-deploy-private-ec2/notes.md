
## Steps

```bash
terraform apply -target=module.vpc
terraform apply -target=module.public-subnets -target=module.private-subnets
terraform apply
```