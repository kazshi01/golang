terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}

# Region for Create ACM in Virginia
provider "aws" {
  region = "us-east-1"
  alias  = "useast1"
}
