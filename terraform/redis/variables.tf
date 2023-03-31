variable "node_type" {
  type        = string
  default     = "cache.t3.micro"
  description = "cache instance type"
}

variable "vpc_id" {
  type        = string
  description = "the vpc that the redis cluster will live in"
}

variable "snapshot_retention_limit" {
  type    = number
  default = 0
}

variable "name_override" {
  type        = string
  default     = ""
  description = "a unique prefix for resource names"
}
