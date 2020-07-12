resource "aws_s3_bucket" "uploads_bucket" {
  bucket = var.uploads_bucket_name
  acl    = "private"

  tags = {
    Name = var.uploads_bucket_name
  }
}

