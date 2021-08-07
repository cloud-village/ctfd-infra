variable "ctfd_version" {
  type        = string
  description = "docker tag for version of CTFd to run"
}

variable "aws_access_key_arn" {
  type        = string
  description = "ARN for aws access key for s3 access"
}

variable "aws_secret_access_key_arn" {
  type        = string
  description = "ARN for aws secret access key for s3 access"
}

variable "mail_username_arn" {
  type        = string
  description = "ARN for mail username"
}

variable "mail_password_arn" {
  type        = string
  description = "ARN for mail password"
}

variable "database_url_arn" {
  type        = string
  description = "ARN for DB uri"
}

variable "workers" {
  type        = string
  description = "number of gunicorn workers"
}

variable "secret_key" {
  type        = string
  description = "The secret value used to creation sessions and sign strings"
}

variable "s3_bucket" {
  type        = string
  description = "s3 bucket to store custom assets"
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

variable "redis_url" {
  type        = string
  description = "redis URI"
}

variable "task_family_name" {
  type        = string
  description = "name of the ECS task"
}

variable "logs_region" {
  type        = string
  description = "region to store logs"
}

variable "iam_role_policy" {
  type        = string
  description = "IAM role policy used by ECS service"
}

variable "target_group_arn" {
  type        = string
  description = "ARN of the load balancer target group"
}

variable "security_groups" {
  type        = list(string)
  description = "security groups used by the ECS service"
}

variable "subnets" {
  type        = list(string)
  description = "subnets used by the ECS service"
}

variable "execution_role_arn" {
  type        = string
  description = "ARN for execution role used by ECS task"
}

variable "desired_count" {
  type        = number
  description = "Number of instances of the task definition to place and keep running"
  default     = 1
}

variable "ecs_task_depends_on" {
  type        = any
  description = "list of resources that have to be created first, avoiding race conditions"
  default     = null
}

variable "cpu" {
  type        = string
  description = "CPU units per container instance"
  default     = "256"
}

variable "memory" {
  type        = string
  description = "MB of memory per container instance"
  default     = "512"
}

variable "max_cpu_threshold" {
  type    = string
  default = "85"
}
