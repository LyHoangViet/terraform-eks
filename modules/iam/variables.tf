variable "role_name" {
  description = "Name of the IAM role"
  type        = string
}

variable "assume_role_service" {
  description = "AWS service that can assume this role (e.g., ec2.amazonaws.com, eks.amazonaws.com)"
  type        = string
  default     = "ec2.amazonaws.com"
}

variable "role_description" {
  description = "Description of the IAM role"
  type        = string
  default     = ""
}

variable "managed_policy_arns" {
  description = "List of AWS managed policy ARNs to attach to the role"
  type        = list(string)
  default     = []
}

variable "inline_policy" {
  description = "Inline policy document (JSON string)"
  type        = string
  default     = null
}

variable "inline_policy_name" {
  description = "Name of the inline policy"
  type        = string
  default     = "inline-policy"
}

variable "custom_policy_document" {
  description = "Custom policy document (JSON string)"
  type        = string
  default     = null
}

variable "custom_policy_name" {
  description = "Name of the custom policy"
  type        = string
  default     = "custom-policy"
}

variable "create_instance_profile" {
  description = "Create an IAM instance profile"
  type        = bool
  default     = false
}

variable "instance_profile_name" {
  description = "Name of the instance profile (if empty, will use role_name-profile)"
  type        = string
  default     = ""
}

variable "create_standalone_policy" {
  description = "Create a standalone IAM policy"
  type        = bool
  default     = false
}

variable "standalone_policy_name" {
  description = "Name of the standalone policy"
  type        = string
  default     = ""
}

variable "standalone_policy_description" {
  description = "Description of the standalone policy"
  type        = string
  default     = ""
}

variable "standalone_policy_document" {
  description = "Policy document for standalone policy (JSON string)"
  type        = string
  default     = null
}

variable "attach_standalone_policy_to_role" {
  description = "Attach standalone policy to the role"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
