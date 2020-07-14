resource "aws_s3_bucket" "uploads_bucket" {
  bucket = var.uploads_bucket_name
  acl    = "private"

  tags = {
    Name = var.uploads_bucket_name
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.uploads_bucket.id

  block_public_acls   = true
  block_public_policy = true
}

resource "aws_ssm_parameter" "bucket_name" {
  name  = "/ctfd/s3/bucket_name"
  type  = "String"
  value = aws_s3_bucket.uploads_bucket.id
}

