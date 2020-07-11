variable "availability_zones" {
  type        = list(string)
  description = "availability zones for autoscaling group"
}

variable "desired_capacity" {
  type        = number
  description = "how many nodes should there be to start? at least the same number of availability zones"
  default     = 1
}

variable "max_size" {
  type        = number
  description = "what is the maximum size of the autoscaling group?"
  default     = 10
}

