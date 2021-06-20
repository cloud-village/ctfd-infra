terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.46.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "2.21.0"
    }


  }
}

/*
provider "aws" {
  region = "us-east-2"
}

provider "cloudflare" {
}
*/
