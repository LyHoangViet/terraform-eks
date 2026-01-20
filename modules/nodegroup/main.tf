# EKS Node Group
resource "aws_eks_node_group" "main" {
  cluster_name    = var.cluster_name
  node_group_name = var.node_group_name
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids
  version         = var.kubernetes_version
  capacity_type   = var.capacity_type
  instance_types  = var.instance_types
  ami_type        = var.ami_type
  disk_size       = var.disk_size

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  update_config {
    max_unavailable = var.max_unavailable
  }

  dynamic "remote_access" {
    for_each = var.ec2_ssh_key != "" ? [1] : []
    content {
      ec2_ssh_key               = var.ec2_ssh_key
      source_security_group_ids = var.source_security_group_ids
    }
  }

  labels = var.labels

  dynamic "taints" {
    for_each = var.taint_key != "" ? [1] : []
    content {
      key    = var.taint_key
      value  = var.taint_value
      effect = var.taint_effect
    }
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.cluster_name}-${var.node_group_name}"
    }
  )
}
