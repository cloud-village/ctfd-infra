variable "iam_instance_profile_name" {
  description = "ec2 instance profile name"
  type        = string
}

variable "image_id" {
  description = "ami id to be used by the launch template"
  type        = string
}

variable "key_name" {
  description = "name of ec2 keypair"
  type        = string
}

variable "availability_zone" {
  description = "availability zone"
  type        = string
  default     = "us-east-2"
}

variable "vpc_id" {
  description = "id for the vpc the security group rules and nodes live in"
  type        = string
}

variable "instance_type" {
  type        = string
  description = "type of ec2 instances to use, defaults to t3.medium"
  default     = "t3.medium"
}

variable "db_security_group" {
  description = "security group to allow nodes in the ASG to talk to the database"
  type        = string
}

variable "redis_security_group" {
  description = "security group to allow nodes in the ASG to talk to redis"
  type        = string
}
