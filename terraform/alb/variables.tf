variable "subnets" {
  type        = list(string)
  description = "subnet ids the ALB should live in"
}

variable "vpc_id" {
  type        = string
  description = "vpc_id that the ALB will live in"
}

variable "certificate_arn" {
  type        = string
  description = "ARN for the SSL certificate used by the ALB"
}

variable "instance_sg_id" {
  type        = string
  description = "security group id that allows traffic between ALB and nodes"
}

variable "inbound_ips" {
  description = "list of allowed inbound IP addresses"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
