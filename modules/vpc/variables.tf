variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "nat_gateway_count" {
  description = "Number of NAT Gateways to create (EIPs will follow this count). Recommended: 1 or equal to number of AZs for HA."
  type        = number
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets (recommended: 3 subnets for enterprise HA across 3 AZs)"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets (recommended: 3 subnets for enterprise HA across 3 AZs)"
  type        = list(string)
}

variable "availability_zones" {
  description = "Availability zones for subnets (should match number of subnets for proper distribution)"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}
