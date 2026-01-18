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

variable "kubernetes_version" {
  description = "Kubernetes version for the node group"
  type        = string
  default     = null
}

variable "capacity_type" {
  description = "Type of capacity associated with the EKS Node Group. Valid values: ON_DEMAND, SPOT"
  type        = string
  default     = "ON_DEMAND"
}

variable "instance_types" {
  description = "List of instance types for the node group"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "ami_type" {
  description = "Type of Amazon Machine Image (AMI) associated with the EKS Node Group"
  type        = string
  default     = "AL2_x86_64"
}

variable "disk_size" {
  description = "Disk size in GiB for worker nodes"
  type        = number
  default     = 20
}

variable "desired_size" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 4
}

variable "min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 1
}

variable "max_unavailable" {
  description = "Maximum number of unavailable nodes during update"
  type        = number
  default     = 1
}

variable "ec2_ssh_key" {
  description = "EC2 Key Pair name that provides access for SSH communication with the worker nodes"
  type        = string
  default     = ""
}

variable "source_security_group_ids" {
  description = "List of source security group IDs for SSH access"
  type        = list(string)
  default     = []
}

variable "labels" {
  description = "Key-value map of Kubernetes labels to apply to the nodes"
  type        = map(string)
  default     = {}
}

variable "taint_key" {
  description = "Key for the taint"
  type        = string
  default     = ""
}

variable "taint_value" {
  description = "Value for the taint"
  type        = string
  default     = ""
}

variable "taint_effect" {
  description = "Effect for the taint (NO_SCHEDULE, NO_EXECUTE, PREFER_NO_SCHEDULE)"
  type        = string
  default     = ""
}

variable "enable_ebs_csi" {
  description = "Enable EBS CSI driver policy attachment"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
