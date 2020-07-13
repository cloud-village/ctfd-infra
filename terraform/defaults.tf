provider "aws" {
  region  = "us-east-2"
  version = "~> 2.70"
}

provider "random" {
  version = "2.3.0"
}

provider "http" {
  version = "~> 1.2"
}
