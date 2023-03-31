variable "vpc_id" {
  description = "id for the vpc that the db nodes live in"
  type        = string
}

variable "db_subnets" {
  description = "subnets that the db nodes live in"
  type        = list(string)
}


variable "instance_class" {
  type        = string
  description = "database instance class"
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  type        = number
  default     = 10
  description = "GB of storage for the database"
}

variable "name_override" {
  type        = string
  default     = ""
  description = "a unique prefix for resource names"
}
