include {
  path = find_in_parent_folders()
}

terraform {
  source = "."
  extra_arguments "vars" {
    commands = ["plan", "apply", "destroy"]
    required_var_files = [
      "terraform.tfvars"
    ]
  }
}

inputs = {
  project_name                    = "my-eks-project"
  environment                     = "dev"
  vpc_cidr                        = "10.0.0.0/16"
  nat_gateway_count               = 1
  public_subnet_cidrs             = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnet_cidrs            = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
  kubernetes_version              = "1.28"
  eks_endpoint_private_access     = true
  eks_endpoint_public_access      = true
  eks_enabled_cluster_log_types   = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  enable_vpc_cni_addon            = true
  enable_coredns_addon            = true
  enable_kube_proxy_addon         = true
  enable_ebs_csi_addon            = false
  vpc_cni_addon_version           = ""
  vpc_cni_service_account_role_arn = ""
  coredns_addon_version           = ""
  kube_proxy_addon_version        = ""
  ebs_csi_addon_version           = ""
  ebs_csi_service_account_role_arn = ""
  node_group_name                 = "main"
  node_group_capacity_type        = "ON_DEMAND"
  node_group_instance_types       = ["t2.micro"]  # bạn vừa đổi
  node_group_ami_type             = "AL2_x86_64"
  node_group_disk_size            = 20
  node_group_desired_size         = 2
  node_group_max_size             = 4
  node_group_min_size             = 1
  node_group_max_unavailable      = 1
  node_group_ec2_ssh_key          = ""
  node_group_source_security_group_ids = []
  node_group_taint_key            = ""
  node_group_taint_value          = ""
  node_group_taint_effect         = ""
  node_group_labels = {
    Environment = "dev"
    NodeGroup   = "main"
  }
  common_tags = {
    Project     = "EKS"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}