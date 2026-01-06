########################################
# Second S3 Bucket using Terraform
########################################

# This resource creates another S3 bucket
resource "aws_s3_bucket" "second_bucket" {

  # Bucket name must be globally unique
  bucket = "jyotiprakash-terraform-second-bucket-67890"

  tags = {
    Name        = "Second-S3-Bucket"
    Environment = "Dev"
    CreatedBy   = "Jenkins-Terraform"
  }
}

########################################
# Enable Versioning on Second Bucket
########################################
resource "aws_s3_bucket_versioning" "second_bucket_versioning" {

  bucket = aws_s3_bucket.second_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

########################################
# Block Public Access for Second Bucket
########################################
resource "aws_s3_bucket_public_access_block" "second_bucket_block" {

  bucket = aws_s3_bucket.second_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

########################################
# Output second bucket name
########################################
output "second_s3_bucket_name" {
  value = aws_s3_bucket.second_bucket.bucket
}