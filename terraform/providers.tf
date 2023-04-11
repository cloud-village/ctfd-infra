terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.62.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.4.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "~> 3.2.0"
    }
  }
}


provider "aws" {
  region = var.region
  default_tags {
    tags = {
      env = var.env
    }
  }
}

provider "random" {}
