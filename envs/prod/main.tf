# Get available AZs
data "aws_availability_zones" "available" {
  state = "available"
}

# VPC Module
module "vpc" {
  source = "../../modules/vpc"

  name_prefix            = "${var.project_name}-${var.environment}"
  vpc_cidr               = var.vpc_cidr
  public_subnet_cidrs    = var.public_subnet_cidrs
  private_subnet_cidrs   = var.private_subnet_cidrs
  availability_zones     = slice(data.aws_availability_zones.available.names, 0, length(var.public_subnet_cidrs))

  tags = merge(
    var.common_tags,
    {
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  )
}

# EKS Module
module "eks" {
  source = "../../modules/eks"

  cluster_name            = "${var.project_name}-${var.environment}"
  vpc_id                  = module.vpc.vpc_id
  subnet_ids              = module.vpc.private_subnet_ids
  kubernetes_version      = var.kubernetes_version
  endpoint_private_access = var.eks_endpoint_private_access
  endpoint_public_access  = var.eks_endpoint_public_access
  enabled_cluster_log_types = var.eks_enabled_cluster_log_types
  kms_key_arn             = var.eks_kms_key_arn

  enable_vpc_cni_addon     = var.enable_vpc_cni_addon
  enable_coredns_addon     = var.enable_coredns_addon
  enable_kube_proxy_addon  = var.enable_kube_proxy_addon
  enable_ebs_csi_addon     = var.enable_ebs_csi_addon

  tags = merge(
    var.common_tags,
    {
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  )
}

# Node Group Module
module "nodegroup" {
  source = "../../modules/nodegroup"

  cluster_name      = module.eks.cluster_name
  node_group_name   = var.node_group_name
  subnet_ids        = module.vpc.private_subnet_ids
  kubernetes_version = var.kubernetes_version
  capacity_type     = var.node_group_capacity_type
  instance_types    = var.node_group_instance_types
  ami_type          = var.node_group_ami_type
  disk_size         = var.node_group_disk_size
  desired_size      = var.node_group_desired_size
  max_size          = var.node_group_max_size
  min_size          = var.node_group_min_size
  max_unavailable   = var.node_group_max_unavailable
  ec2_ssh_key       = var.node_group_ec2_ssh_key
  enable_ebs_csi    = var.enable_ebs_csi_addon

  labels = var.node_group_labels

  tags = merge(
    var.common_tags,
    {
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  )
}
