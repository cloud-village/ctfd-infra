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
}

variable "vpc_id" {
  description = "id for the vpc the security group rules and nodes live in"
  type        = string
}

variable "alb_security_group_name" {
  type = string
  description = "name of security group used by the "
}
