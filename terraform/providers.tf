provider "aws" {
  region  = var.region
  version = "~> 3.46.0"
}

provider "random" {
  version = "3.1.0"
}

provider "cloudflare" {
    version = "~>2.21.0"
}
