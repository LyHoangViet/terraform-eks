variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets (recommended: 3 subnets for enterprise HA across 3 AZs)"
  type        = list(string)
  
  validation {
    condition     = length(var.public_subnet_cidrs) >= 2 && length(var.public_subnet_cidrs) <= 6
    error_message = "Number of public subnets must be between 2 and 6 for high availability."
  }
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets (recommended: 3 subnets for enterprise HA across 3 AZs)"
  type        = list(string)
  
  validation {
    condition     = length(var.private_subnet_cidrs) >= 2 && length(var.private_subnet_cidrs) <= 6
    error_message = "Number of private subnets must be between 2 and 6 for high availability."
  }
}

variable "availability_zones" {
  description = "Availability zones for subnets (should match number of subnets for proper distribution)"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
