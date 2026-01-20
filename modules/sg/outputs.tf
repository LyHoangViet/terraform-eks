output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.this.id
}

output "security_group_arn" {
  description = "ARN of the security group"
  value       = aws_security_group.this.arn
}

output "security_group_name" {
  description = "Name of the security group"
  value       = aws_security_group.this.name
}

# Backwards compatibility for existing references
output "alb_security_group_id" {
  description = "Security group ID (kept for backward compatibility)"
  value       = aws_security_group.this.id
}
