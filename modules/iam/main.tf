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

# Inline Policy
resource "aws_iam_role_policy" "inline_policy" {
  count = var.inline_policy != null ? 1 : 0

  name   = var.inline_policy_name
  role   = aws_iam_role.main.id
  policy = var.inline_policy
}

# Custom Policy Document
resource "aws_iam_role_policy" "custom_policy" {
  count = var.custom_policy_document != null ? 1 : 0

  name   = var.custom_policy_name
  role   = aws_iam_role.main.id
  policy = var.custom_policy_document
}

# Instance Profile (for EC2 instances)
resource "aws_iam_instance_profile" "main" {
  count = var.create_instance_profile ? 1 : 0

  name = var.instance_profile_name != "" ? var.instance_profile_name : "${var.role_name}-profile"
  role = aws_iam_role.main.name

  tags = var.tags
}

# IAM Policy (standalone)
resource "aws_iam_policy" "main" {
  count = var.create_standalone_policy ? 1 : 0

  name        = var.standalone_policy_name
  description = var.standalone_policy_description
  policy      = var.standalone_policy_document

  tags = merge(
    var.tags,
    {
      Name = var.standalone_policy_name
    }
  )
}

# Attach Standalone Policy to Role
resource "aws_iam_role_policy_attachment" "standalone_policy" {
  count = var.create_standalone_policy && var.attach_standalone_policy_to_role ? 1 : 0

  role       = aws_iam_role.main.name
  policy_arn = aws_iam_policy.main[0].arn
}
