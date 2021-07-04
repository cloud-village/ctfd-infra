variable "vpc_id" {
  type        = string
  description = "vpc_id that all the things will live in"
}

variable "alb_subnets" {
  type        = list(string)
  description = "subnet ids the ALB should live in"
}

variable "certificate_arn" {
  type        = string
  description = "ARN for the SSL certificate used by the ALB"
  default     = ""
}

variable "route53_zone_id" {
  type        = string
  description = "hosted zone id"
  default     = ""
}

variable "region" {
  type        = string
  description = "aws region the resources will be created in"
}

variable "create_aws_dns" {
  type        = bool
  description = "do you want to create DNS entries in route53?"
  default     = false
}

variable "inbound_ips" {
  description = "list of allowed inbound IP addresses"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "ctfd_version" {
  type        = string
  description = "docker tag for CTFd version"
  default     = "mark-3.3.0"
}

variable "workers" {
  type        = string
  description = "number of gunicorn workers"
  default     = 3
}

variable "mailfrom_addr" {
  type        = string
  description = "The email address that emails are sent from if not overridden in the configuration panel."
}


variable "mail_server" {
  type        = string
  description = "The mail server that emails are sent from if not overriden in the configuration panel."
}

variable "mail_port" {
  type        = string
  description = "The mail port that emails are sent from if not overriden in the configuration panel."
}

variable "ecs_subnets" {
  type        = list(string)
  description = "subnets used by the ECS service"
}

variable "logs_region" {
  type        = string
  description = "region to store logs"
}

variable "https_redirect_enabled" {
  type        = bool
  description = "is the https redirect enabled?"
  default     = false
}

variable "ssl_termination_enabled" {
  type        = bool
  description = "is SSL termination enabled?"
  default     = false
}

variable "allow_cloudflare" {
  type        = bool
  description = "is cloudflare being used?"
  default     = false
}

variable "desired_count" {
  type        = number
  description = "Number of instances of the task definition to place and keep running"
}

variable "db_subnets" {
  description = "subnets that the db nodes live in"
  type        = list(string)
}

variable "ecs_task_depends_on" {
  type        = any
  description = "list of resources that have to be created first, avoiding race conditions"
  default     = null
}

variable "mail_username_arn" {
  type        = string
  description = "SSM or ASM ARN for the username used to authenticate to the SMTP server"
}

variable "mail_password_arn" {
  type        = string
  description = "SSM or ASM ARN for the username used to authenticate to the SMTP server"
}


