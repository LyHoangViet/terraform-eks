variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "cluster_role_arn" {
  description = "IAM role ARN for the EKS cluster (created via IAM module)"
  type        = string
}

variable "cluster_security_group_id" {
  description = "Security group ID for the EKS cluster (created via SG module)"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "kubernetes_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
}

variable "endpoint_private_access" {
  description = "Enable private API server endpoint"
  type        = bool
}

variable "endpoint_public_access" {
  description = "Enable public API server endpoint"
  type        = bool
}

variable "enabled_cluster_log_types" {
  description = "List of control plane logging types to enable"
  type        = list(string)
}

variable "kms_key_arn" {
  description = "KMS key ARN for EKS cluster encryption"
  type        = string
}

variable "enable_vpc_cni_addon" {
  description = "Enable VPC CNI addon"
  type        = bool
}

variable "vpc_cni_addon_version" {
  description = "Version of VPC CNI addon"
  type        = string
}

variable "vpc_cni_service_account_role_arn" {
  description = "Service account role ARN for VPC CNI addon"
  type        = string
}

variable "enable_coredns_addon" {
  description = "Enable CoreDNS addon"
  type        = bool
}

variable "coredns_addon_version" {
  description = "Version of CoreDNS addon"
  type        = string
}

variable "enable_kube_proxy_addon" {
  description = "Enable kube-proxy addon"
  type        = bool
}

variable "kube_proxy_addon_version" {
  description = "Version of kube-proxy addon"
  type        = string
}

variable "enable_ebs_csi_addon" {
  description = "Enable EBS CSI driver addon"
  type        = bool
}

variable "ebs_csi_addon_version" {
  description = "Version of EBS CSI driver addon"
  type        = string
}

variable "ebs_csi_service_account_role_arn" {
  description = "Service account role ARN for EBS CSI driver addon"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}
