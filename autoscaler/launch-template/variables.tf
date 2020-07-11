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

variable "vpc_security_group_ids" {
  description = "comma-delimited list of security groups"
  type        = string
}
