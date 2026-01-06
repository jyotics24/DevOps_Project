# # Tell Terraform which provider to use
# provider "aws" {
#   region = "ap-south-1"   # Mumbai region
# }

# # Create an S3 bucket
# resource "aws_s3_bucket" "my_bucket" {
#   bucket = "jyotiprakash-terraform-jenkins-bucket-12345"
# }

# # Optional: make bucket private
# resource "aws_s3_bucket_acl" "bucket_acl" {
#   bucket = aws_s3_bucket.my_bucket.id
#   acl    = "private"
# }
########################################
# Terraform configuration block
########################################
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

########################################
# AWS Provider configuration
########################################
provider "aws" {
  region = "ap-south-1"   # Mumbai region
}

########################################
# Create an S3 Bucket
########################################
resource "aws_s3_bucket" "my_bucket" {

  # Bucket name must be globally unique
  bucket = "jyotiprakash-terraform-jenkins-bucket-12345"

  # Tags for identification
  tags = {
    Name        = "Terraform-Jenkins-Bucket"
    Environment = "Dev"
  }
}

########################################
# Enable Versioning on S3 Bucket
########################################
resource "aws_s3_bucket_versioning" "versioning" {

  # Reference the bucket created above
  bucket = aws_s3_bucket.my_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

########################################
# Block all public access (Best Practice)
########################################
resource "aws_s3_bucket_public_access_block" "block_public" {

  bucket = aws_s3_bucket.my_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

########################################
# Output bucket name after creation
########################################
output "s3_bucket_name" {
  value = aws_s3_bucket.my_bucket.bucket
}
