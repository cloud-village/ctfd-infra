variable "zone_id" {
  type        = string
  description = "hosted zone id"
}

variable "dns_name" {
  type        = string
  description = "human-friendly DNS name to use for the ALB"
  default     = "ctfd-test"
}

variable "alb_dns_name" {
  type        = string
  description = "alb AWS DNS name"
}

variable "alb_zone_id" {
  type        = string
  description = "AWS DNS zone id of the ALB"
}
