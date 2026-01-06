# Tell Terraform which provider to use
provider "aws" {
  region = "ap-south-1"   # Mumbai region
}

# Create an S3 bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "jyotiprakash-terraform-jenkins-bucket-12345"
}

# Optional: make bucket private
resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.my_bucket.id
  acl    = "private"
}
