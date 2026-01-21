# remote_state {
#   backend = "s3"
#   config = {
#     bucket         = "tfstate-bucket"
#     key            = "${path_relative_to_include()}/terraform.tfstate"
#     region         = "ap-southeast-1"
#     encrypt        = true
#     dynamodb_table = "tfstate-lock"
#   }
# }

generate "provider" {
  path      = "terraform.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
EOF
}