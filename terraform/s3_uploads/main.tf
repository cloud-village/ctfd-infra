resource "aws_s3_bucket" "uploads_bucket" {
  bucket = var.uploads_bucket_name
  acl    = "private"

  tags = {
    Name = var.uploads_bucket_name
  }
}

resource "aws_s3_bucket_public_access_block" "uploads_block" {
  bucket = aws_s3_bucket.uploads_bucket.id

  block_public_acls   = true
  block_public_policy = true
}

