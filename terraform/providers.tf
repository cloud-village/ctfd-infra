terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.47.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "2.1.0"
    }
  }
}


provider "aws" {
  region = var.region
}

provider "random" {}
