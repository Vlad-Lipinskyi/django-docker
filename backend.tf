terraform {
  backend "s3" {
    bucket         = "gomni-practice-terraform-state"
    key            = "lesson-5/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "practice-terraform-terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}
