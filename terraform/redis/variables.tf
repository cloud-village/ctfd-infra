variable "node_type" {
  type        = string
  default     = "cache.t3.micro"
  description = "cache instance type"
}

variable "vpc_id" {
  type        = string
  description = "the vpc that the redis cluster will live in"
}
