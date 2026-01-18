variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, uat, prod)"
  type        = string
  default     = "prod"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.2.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.2.1.0/24", "10.2.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.2.11.0/24", "10.2.12.0/24"]
}

variable "kubernetes_version" {
  description = "Kubernetes version for EKS cluster"
  type        = string
  default     = "1.28"
}

variable "eks_endpoint_private_access" {
  description = "Enable private API server endpoint"
  type        = bool
  default     = true
}

variable "eks_endpoint_public_access" {
  description = "Enable public API server endpoint"
  type        = bool
  default     = true
}

variable "eks_enabled_cluster_log_types" {
  description = "List of control plane logging types to enable"
  type        = list(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "eks_kms_key_arn" {
  description = "KMS key ARN for EKS cluster encryption"
  type        = string
  default     = ""
}

variable "enable_vpc_cni_addon" {
  description = "Enable VPC CNI addon"
  type        = bool
  default     = true
}

variable "enable_coredns_addon" {
  description = "Enable CoreDNS addon"
  type        = bool
  default     = true
}

variable "enable_kube_proxy_addon" {
  description = "Enable kube-proxy addon"
  type        = bool
  default     = true
}

variable "enable_ebs_csi_addon" {
  description = "Enable EBS CSI driver addon"
  type        = bool
  default     = false
}

variable "node_group_name" {
  description = "Name of the node group"
  type        = string
  default     = "main"
}

variable "node_group_capacity_type" {
  description = "Type of capacity associated with the EKS Node Group"
  type        = string
  default     = "ON_DEMAND"
}

variable "node_group_instance_types" {
  description = "List of instance types for the node group"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_group_ami_type" {
  description = "Type of Amazon Machine Image (AMI) associated with the EKS Node Group"
  type        = string
  default     = "AL2_x86_64"
}

variable "node_group_disk_size" {
  description = "Disk size in GiB for worker nodes"
  type        = number
  default     = 20
}

variable "node_group_desired_size" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "node_group_max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 4
}

variable "node_group_min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 1
}

variable "node_group_max_unavailable" {
  description = "Maximum number of unavailable nodes during update"
  type        = number
  default     = 1
}

variable "node_group_ec2_ssh_key" {
  description = "EC2 Key Pair name for SSH access"
  type        = string
  default     = ""
}

variable "node_group_labels" {
  description = "Key-value map of Kubernetes labels to apply to the nodes"
  type        = map(string)
  default     = {}
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    Project     = "EKS"
    Environment = "prod"
    ManagedBy   = "Terraform"
  }
}
