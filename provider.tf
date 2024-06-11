provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "atlastech-state-bucket"
    key            = "terraform.tfstate"
    region         = "eu-east-1"
  }
}