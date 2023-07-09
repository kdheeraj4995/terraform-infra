terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.7"
    }
  }
  required_version = ">= 1.2.0"
}

variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "ap-south-1"
}

provider "aws" {
  access_key          = var.AWS_ACCESS_KEY
  secret_key          = var.AWS_SECRET_KEY
  region              = var.AWS_REGION
  allowed_account_ids = []
}

terraform {
  backend "s3" {
    bucket = "application-infra-terraform-state"
    key    = "common-infra/terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "application-infra-terraform-state-lock"
    encrypt        = true
  }
}
