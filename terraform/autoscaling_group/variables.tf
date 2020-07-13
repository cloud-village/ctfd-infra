variable "availability_zones" {
  type        = list(string)
  description = "availability zones for autoscaling group"
  default     = ["us-east-2a", "us-east-2b", "us-east-2c"]
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

variable "launch_template_id" {
  type        = string
  description = "launch template id to use for the autoscaling group"
}

variable "target_group_arns" {
  type        = string
  description = "ARN of load balancer target group this autoscaling group is managing the nodes for"
}

variable "scale_up_threshold" {
  type        = number
  description = "percentage of CPU to trigger scale up"
  default     = 80
}

variable "scale_down_threshold" {
  type        = number
  description = "percentage of CPU to trigger scale down"
  default     = 50
}
