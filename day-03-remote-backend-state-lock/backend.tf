terraform {
  backend "s3" {
    bucket         = "numan-terraform-state-123456789012"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}