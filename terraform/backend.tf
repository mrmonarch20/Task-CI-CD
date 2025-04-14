terraform {
  backend "s3" {
    bucket         = "terraform-state-mrmonarch20"
    key            = "eks/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
