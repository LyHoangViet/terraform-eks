# Get available AZs
data "aws_availability_zones" "available" {
  state = "available"
}

# VPC Module
module "vpc" {
  source = "../../modules/vpc"

  name_prefix            = "${var.project_name}-${var.environment}"
  vpc_cidr               = var.vpc_cidr
  nat_gateway_count      = var.nat_gateway_count
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

# IAM for EKS Cluster
module "eks_iam" {
  source = "../../modules/iam"

  role_name           = "${var.project_name}-${var.environment}-cluster-role"
  assume_role_service = "eks.amazonaws.com"
  role_description    = "EKS cluster role"
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController",
  ]

  tags = merge(
    var.common_tags,
    {
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  )
}

# Security Group for EKS Cluster
module "eks_sg" {
  source = "../../modules/sg"

  name_prefix = "${var.project_name}-${var.environment}-cluster"
  vpc_id      = module.vpc.vpc_id

  description       = "Security group for EKS cluster"
  ingress_rules     = []
  egress_rules      = []
  allow_all_egress  = true

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

  cluster_name              = "${var.project_name}-${var.environment}"
  vpc_id                    = module.vpc.vpc_id
  subnet_ids                = module.vpc.private_subnet_ids
  cluster_role_arn          = module.eks_iam.role_arn
  cluster_security_group_id = module.eks_sg.alb_security_group_id
  kubernetes_version        = var.kubernetes_version
  endpoint_private_access   = var.eks_endpoint_private_access
  endpoint_public_access    = var.eks_endpoint_public_access
  enabled_cluster_log_types = var.eks_enabled_cluster_log_types
  kms_key_arn               = var.eks_kms_key_arn

  enable_vpc_cni_addon     = var.enable_vpc_cni_addon
  vpc_cni_addon_version    = var.vpc_cni_addon_version
  vpc_cni_service_account_role_arn = var.vpc_cni_service_account_role_arn

  enable_coredns_addon     = var.enable_coredns_addon
  coredns_addon_version    = var.coredns_addon_version

  enable_kube_proxy_addon  = var.enable_kube_proxy_addon
  kube_proxy_addon_version = var.kube_proxy_addon_version

  enable_ebs_csi_addon     = var.enable_ebs_csi_addon
  ebs_csi_addon_version    = var.ebs_csi_addon_version
  ebs_csi_service_account_role_arn = var.ebs_csi_service_account_role_arn

  tags = merge(
    var.common_tags,
    {
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  )
}

# Node Group Module
module "nodegroup_iam" {
  source = "../../modules/iam"

  role_name           = "${var.project_name}-${var.environment}-${var.node_group_name}-node-role"
  assume_role_service = "ec2.amazonaws.com"
  role_description    = "EKS managed node group role"
  managed_policy_arns = compact([
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    var.enable_ebs_csi_addon ? "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy" : "",
  ])

  tags = merge(
    var.common_tags,
    {
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  )
}

module "nodegroup" {
  source = "../../modules/nodegroup"

  cluster_name      = module.eks.cluster_name
  node_group_name   = var.node_group_name
  subnet_ids        = module.vpc.private_subnet_ids
  node_role_arn     = module.nodegroup_iam.role_arn
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
  source_security_group_ids = var.node_group_source_security_group_ids
  taint_key         = var.node_group_taint_key
  taint_value       = var.node_group_taint_value
  taint_effect      = var.node_group_taint_effect

  labels = var.node_group_labels

  tags = merge(
    var.common_tags,
    {
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  )
}
