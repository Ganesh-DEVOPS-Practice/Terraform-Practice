
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.84.0"
    }
  }
  backend "s3" {
    bucket = "ganesh-devops-state"
    key = "expense-vpc"
    region = "us-east-1"
    dynamodb_table = "ganesh-devops-locking"
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}