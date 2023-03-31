variable "uploads_bucket_name" {
  type        = string
  description = "name of the s3 bucket uploads will be saved to"
}

variable "region" {
  type        = string
  description = "aws region the resources will be created in"
}

variable "name_override" {
  type        = string
  default     = ""
  description = "a unique prefix for resource names"
}
