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

variable "use_ecr" {
  type        = bool
  description = "whether to use ECR"
  default     = "false"
}

variable "ecr_region" {
  type        = string
  description = "region for ECR repo"
  default     = ""
}

variable "ecr_repo_name" {
  type        = string
  description = "name of the ECR repo used"
  default     = ""
}
