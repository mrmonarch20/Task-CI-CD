provider "aws" {
  region = "ap-south-1"
}
resource "aws_s3_bucket" "dummy" {
  bucket = "just-a-dummy-bucket-for-initialization-123456"
}