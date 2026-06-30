terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket = "devops-terraform-remote"
    key    = "remote-roboshop-dev-frontend-lb"
    region = "us-east-1"
    use_lockfile=true
    encrypt = true
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}