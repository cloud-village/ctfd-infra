variable "uploads_bucket_name" {
  type        = string
  description = "name of the s3 bucket uploads will be saved to"
}

variable "region" {
  type = string
  description = "aws region the resources will live in"
}
