terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.31"
    }
  }
}

provider "aws" {
  region  = var.aws_region
}
