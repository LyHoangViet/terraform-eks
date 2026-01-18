terraform {
  backend "s3" {
    bucket         = "" # Set your S3 bucket name
    key            = "dev/terraform.tfstate"
    region         = "" # Set your AWS region
    encrypt        = true
    dynamodb_table = "" # Set your DynamoDB table name for state locking
  }
}
