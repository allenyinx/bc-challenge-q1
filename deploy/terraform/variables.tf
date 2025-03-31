variable "vpc_id" {
  description = "VPC ID where EFS will be deployed"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for EFS mount targets"
  type        = list(string)
}

variable "eks_cluster_sg" {
  description = "EKS cluster security group ID"
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace for resources"
  type        = string
  default     = "blockchain"
}

variable "throughput_mode" {
  description = "EFS throughput mode (bursting|elastic|provisioned)"
  type        = string
  default     = "bursting"
}

variable "provisioned_throughput" {
  description = "Throughput in MiB/s (required if mode=provisioned)"
  type        = number
  default     = null
}