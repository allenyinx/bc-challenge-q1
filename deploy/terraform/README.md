# AWS EFS terraform module
This module creates an AWS EFS filesystem.

# References
- [Terraform AWS EFS](https://github.com/terraform-aws-modules/terraform-aws-efs)

# Pre-condition
- EKS sg id: sg-12345678
- EFS VPC created with id: vpc-12345678
- EFS private subnets created with ids: subnet-123, subnet-456
- EKS AWS efs provisioner plugin installed

# Getting Started
```shell
export AWS_ACCESS_KEY_ID="your_access_key"
export AWS_SECRET_ACCESS_KEY="your_secret_key"

terraform init

terraform validate  # Should show no errors

terraform plan \
  -var="vpc_id=vpc-12345678" \
  -var='private_subnet_ids=["subnet-123","subnet-456"]' \
  -var="eks_cluster_sg=sg-12345678"

terraform apply \
  -var="vpc_id=vpc-12345678" \
  -var='private_subnet_ids=["subnet-123","subnet-456"]' \
  -var="eks_cluster_sg=sg-12345678"
```