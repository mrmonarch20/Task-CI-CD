terraform {
  backend "s3" {
    bucket         = "terraform-state-mrmonarch20-ap-south-1"
    key            = "eks/terraform.tfstate"
    region         = "ap-south-1"
    use_lockfile   = true
    encrypt        = true
  }
}
