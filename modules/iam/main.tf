# IAM Role
resource "aws_iam_role" "main" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = var.assume_role_service
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  description = var.role_description

  tags = merge(
    var.tags,
    {
      Name = var.role_name
    }
  )
}

# Attach Managed Policies
resource "aws_iam_role_policy_attachment" "managed_policies" {
  for_each = toset(var.managed_policy_arns)

  role       = aws_iam_role.main.name
  policy_arn = each.value
}
