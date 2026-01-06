# Configure AWS provider
provider "aws" {
  region = "ap-south-1"   # AWS region
}

# Create an S3 bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket        = "jyoti-jenkins-terraform-s3-demo"  # Bucket name (must be unique)
  force_destroy = true                               # Delete bucket even if not empty
}
