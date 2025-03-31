resource "aws_security_group" "efs" {
  name        = "chain-maind-efs"
  description = "EFS access for Crypto.org nodes"
  vpc_id      = var.vpc_id

  ingress {
    description      = "NFS from EKS nodes"
    from_port        = 2049
    to_port          = 2049
    protocol         = "tcp"
    security_groups  = [var.eks_cluster_sg]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Application = "blockchain"
  }
}

resource "aws_security_group_rule" "efs_access" {
  security_group_id = aws_security_group.efs.id
  type              = "ingress"
  from_port         = 2049
  to_port           = 2049
  protocol          = "tcp"
  source_security_group_id = var.eks_cluster_sg
}