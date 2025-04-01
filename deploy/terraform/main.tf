provider "aws" {
  region = "us-west-2" # Choose the appropriate region
  allowed_account_ids = ["123456789012"]  # Restrict to my AWS account
  default_tags {
    tags = {
      Environment = "dev"
      Terraform   = "true"
    }
  }
}

# EFS Filesystem
resource "aws_efs_file_system" "chain_maind" {
  creation_token   = "chain-maind-efs"
  performance_mode = "generalPurpose"
  throughput_mode  = var.throughput_mode
  encrypted        = true

  provisioned_throughput_in_mibps = var.throughput_mode == "provisioned" ? var.provisioned_throughput : null

  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }

  tags = {
    Name        = "chain-maind-efs"
    Application = "blockchain"
  }
}

# Mount Targets
resource "aws_efs_mount_target" "nodes" {
  count           = length(var.private_subnet_ids)
  file_system_id  = aws_efs_file_system.chain_maind.id
  subnet_id       = var.private_subnet_ids[count.index]
  security_groups = [aws_security_group.efs.id]
}

resource "aws_efs_access_point" "chain_maind" {
  file_system_id = aws_efs_file_system.chain_maind.id

  posix_user {
    gid = 1000
    uid = 1000
  }

  root_directory {
    path = "/chain-maind"
    creation_info {
      owner_gid   = 1000
      owner_uid   = 1000
      permissions = "755"
    }
  }

  tags = {
    Name = "chain-maind-access-point"
  }
}

# EFS CSI Driver IAM Policy
data "aws_iam_policy_document" "efs_csi" {
  statement {
    actions = [
      "elasticfilesystem:DescribeAccessPoints",
      "elasticfilesystem:DescribeFileSystems",
      "elasticfilesystem:DescribeMountTargets",
      "ec2:DescribeAvailabilityZones"
    ]
    resources = ["*"]
  }

  statement {
    actions   = ["elasticfilesystem:CreateAccessPoint"]
    resources = [aws_efs_file_system.chain_maind.arn]
  }

  statement {
    actions   = ["elasticfilesystem:DeleteAccessPoint"]
    resources = ["arn:aws:elasticfilesystem:*:*:access-point/*"]
  }
}

resource "aws_iam_policy" "efs_csi" {
  name        = "EFS_CSI_Driver_Policy"
  description = "Policy for EFS CSI driver"
  policy      = data.aws_iam_policy_document.efs_csi.json
}