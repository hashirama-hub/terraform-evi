
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.69.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  # Configuration options
  region = var.evi_region
}