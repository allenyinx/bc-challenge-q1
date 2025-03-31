output "efs_id" {
  description = "EFS filesystem ID"
  value       = aws_efs_file_system.chain_maind.id
}

output "efs_security_group_id" {
  description = "Security group ID for EFS"
  value       = aws_security_group.efs.id
}

output "efs_ap_id" {
  description = "Access point ID for Kubernetes"
  value       = aws_efs_access_point.chain_maind.id
}

output "csi_policy_arn" {
  description = "IAM policy ARN for EFS CSI driver"
  value       = aws_iam_policy.efs_csi.arn
}