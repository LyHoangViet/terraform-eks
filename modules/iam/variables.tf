variable "role_name" {
  description = "Name of the IAM role"
  type        = string
}

variable "assume_role_service" {
  description = "AWS service that can assume this role (e.g., ec2.amazonaws.com, eks.amazonaws.com)"
  type        = string
}

variable "role_description" {
  description = "Description of the IAM role"
  type        = string
}

variable "managed_policy_arns" {
  description = "List of AWS managed policy ARNs to attach to the role"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
