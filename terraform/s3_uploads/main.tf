resource "aws_s3_bucket" "uploads_bucket" {
  bucket = "${local.name}-${random_string.bucket_seed.result}"
  acl    = "private"

  tags = {
    Name = local.name
  }
}

resource "aws_s3_bucket_public_access_block" "uploads_block" {
  bucket = aws_s3_bucket.uploads_bucket.id

  block_public_acls   = true
  block_public_policy = true
}

locals {
  # if name_override is not provided, use "ctfd", else append name_override to "ctfd"
  name = var.name_override == "" ? "ctfd" : "ctfd-${var.name_override}"
}
