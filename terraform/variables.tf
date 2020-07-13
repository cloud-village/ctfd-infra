variable "packer_image_id" {
  type        = string
  description = "ami build by packer"
}

variable "template_az" {
  type        = string
  description = "availability zone used by the launch template"
}

variable "key_name" {
  type        = string
  description = "ec2 keypair"
}

variable "vpc_id" {
  type        = string
  description = "vpc_id that all the things will live in"
}


variable "availability_zones" {
  type        = string
  description = "availability zones where things will live"
}

variable "max_size" {
  type        = number
  description = "what is the maximum size of the autoscaling group?"
}

variable "desired_capacity" {
  type        = number
  description = "how many nodes should there be to start? at least the same number of availability zones"
  default     = 2
}

variable "subnets" {
  type        = list(string)
  description = "subnet ids the ALB should live in"
}

variable "certificate_arn" {
  type        = string
  description = "ARN for the SSL certificate used by the ALB"
}

variable "uploads_bucket_name" {
  description = "name of the bucket for uploads"
  type        = string
}

variable "zone_id" {
  type        = string
  description = "hosted zone id"
}
