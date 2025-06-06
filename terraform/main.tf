# Configure the AWS Provider

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "2.7.0"
    }
  }
  backend "s3" {
    bucket = "worldhealth-etl-backend-bucket"
    key = "who-etl-project/terraform.tfstate"
    region = "eu-west-2"
  }
}

provider "aws" {
  region = "eu-west-2"

  default_tags {
    tags = { ProjectName = "WHO-ETL"
      DeployedFrom = "terraform"
      Repository   = "WHO-ETL"
    }
  }
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}