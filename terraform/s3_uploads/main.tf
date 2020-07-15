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

resource "aws_secretsmanager_secret" "example" {
  name = "/ctfd/s3/bucket_name"
}

resource "aws_secretsmanager_secret_version" "example" {
  secret_id     = aws_secretsmanager_secret.example.id
  secret_string = aws_s3_bucket.uploads_bucket.id
}

