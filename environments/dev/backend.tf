terraform {
  backend "s3" {
    bucket       = "444198540026-test-bucket"
    key          = "dev/terraform.tfstate"
    region       = "ap-south-1"
  }
}