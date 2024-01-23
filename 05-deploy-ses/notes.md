
### Steps

1. Execute the following commands

```sh
terraform plan -var="admin_email=admin@mail.com" -var="iam_policy=ses-policy" 
terraform apply -var="admin_email=admin@mail.com" -var="iam_policy=ses-policy" 
terraform output smtp_password
```

2. Check you email and click on verification link.

3. Test email.

4. Destroy the resources

```sh
terraform destroy -var="admin_email=admin@mail.com" -var="iam_policy=ses-policy" 
```