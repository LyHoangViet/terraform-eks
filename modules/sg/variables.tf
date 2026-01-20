variable "name_prefix" {
  description = "Prefix for security group name"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where the security group will be created"
  type        = string
}

variable "description" {
  description = "Description of the security group"
  type        = string
}

variable "ingress_rules" {
  description = <<EOT
List of ingress rules for the security group.
Each object supports:
  - description
  - from_port
  - to_port
  - protocol
  - cidr_blocks
  - ipv6_cidr_blocks
  - security_groups
EOT
  type = list(object({
    description      = optional(string, "")
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = optional(list(string), [])
    ipv6_cidr_blocks = optional(list(string), [])
    security_groups  = optional(list(string), [])
  }))
}

variable "egress_rules" {
  description = <<EOT
List of egress rules for the security group.
Same schema as ingress_rules. If empty and allow_all_egress=true, a default allow-all egress rule will be created.
EOT
  type = list(object({
    description      = optional(string, "")
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = optional(list(string), [])
    ipv6_cidr_blocks = optional(list(string), [])
    security_groups  = optional(list(string), [])
  }))
}

variable "allow_all_egress" {
  description = "If true and egress_rules is empty, create a default allow-all egress rule (0.0.0.0/0, ::/0)."
  type        = bool
}

variable "tags" {
  description = "Tags to apply to the security group"
  type        = map(string)
}
