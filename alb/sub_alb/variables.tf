/*
Module variables
*/

variable "alb_is_internal" {
  description = "Determines if the ALB is internal. Default: false"
  default     = false
}

variable "alb_name" {
  description = "The name of the ALB as will show in the AWS EC2 ELB console."
}

variable "alb_security_groups" {
  description = "A comma separated string of security groups with which we associate the ALB. e.g. 'sg-edcd9784,sg-edcd9785'"
}

variable "log_bucket" {
  description = "S3 bucket for storing ALB access logs."
}

variable "log_prefix" {
  description = "S3 prefix within the log_bucket under which logs are stored."
}

variable "subnets" {
  description = "A comma delimited list of subnets to associate with the ALB. e.g. 'subnet-1a2b3c4d,subnet-1a2b3c4e,subnet-1a2b3c4f'"
}
