variable "availability_zones" {
  type        = list(string)
  description = "list of availability_zones"
}

variable "vpc_id" {
  description = "id for the vpc that the db nodes live in"
  type        = string
}

