variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "node_group_name" {
  description = "Name of the node group"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the node group"
  type        = list(string)
}

variable "node_role_arn" {
  description = "IAM role ARN for the EKS node group (created via IAM module)"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version for the node group"
  type        = string
}

variable "capacity_type" {
  description = "Type of capacity associated with the EKS Node Group. Valid values: ON_DEMAND, SPOT"
  type        = string
}

variable "instance_types" {
  description = "List of instance types for the node group"
  type        = list(string)
}

variable "ami_type" {
  description = "Type of Amazon Machine Image (AMI) associated with the EKS Node Group"
  type        = string
}

variable "disk_size" {
  description = "Disk size in GiB for worker nodes"
  type        = number
}

variable "desired_size" {
  description = "Desired number of worker nodes"
  type        = number
}

variable "max_size" {
  description = "Maximum number of worker nodes"
  type        = number
}

variable "min_size" {
  description = "Minimum number of worker nodes"
  type        = number
}

variable "max_unavailable" {
  description = "Maximum number of unavailable nodes during update"
  type        = number
}

variable "ec2_ssh_key" {
  description = "EC2 Key Pair name that provides access for SSH communication with the worker nodes"
  type        = string
}

variable "source_security_group_ids" {
  description = "List of source security group IDs for SSH access"
  type        = list(string)
}

variable "labels" {
  description = "Key-value map of Kubernetes labels to apply to the nodes"
  type        = map(string)
}

variable "taint_key" {
  description = "Key for the taint"
  type        = string
}

variable "taint_value" {
  description = "Value for the taint"
  type        = string
}

variable "taint_effect" {
  description = "Effect for the taint (NO_SCHEDULE, NO_EXECUTE, PREFER_NO_SCHEDULE)"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}
