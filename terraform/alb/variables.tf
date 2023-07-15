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
  default     = ""
}

variable "inbound_ips" {
  description = "list of allowed inbound IP addresses"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "https_redirect_enabled" {
  type        = bool
  description = "is the https redirect enabled?"
  default     = false
}

variable "allow_cloudflare" {
  type        = bool
  description = "is cloudflare being used?"
  default     = false
}

variable "name_override" {
  type        = string
  default     = ""
  description = "a unique prefix for resource names"
}
