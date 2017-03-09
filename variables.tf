/*
Provider variables
*/
variable "aws_access_key" {}

variable "aws_secret_key" {}
variable "aws_region" {}

/*
Module variables
*/

variable "alb_name" {
  description = "The name of the ALB as will show in the AWS EC2 ELB console."
}

variable "alb_security_groups" {
  description = "A comma separated string of security groups with which we associate the ALB. e.g. 'sg-edcd9784,sg-edcd9785'"
}

variable "ssl_certificate_id" {
  description = "The ARN of the SSL Certificate. e.g. 'arn:aws:iam::123456789012:server-certificate/ProdServerCert'"
}

variable "subnets" {
  description = "A comma delimited list of subnets to associate with the ALB. e.g. 'subnet-1a2b3c4d,subnet-1a2b3c4e,subnet-1a2b3c4f'"
}

variable "backend_port" {
  description = "The port the service on the EC2 instances listen on."
}

variable "backend_protocol" {
  description = "The protocol the backend service speaks. Options: http, https, tcp, ssl (secure tcp)."
}

variable "health_check_target" {
  description = "The URL the ELB should use for health checks. e.g. HTTPS:443/health"
}

variable "log_bucket" {
  default = ""
}

variable "log_prefix" {
  default = ""
}

/*
variable "alb_is_internal" {
  description = "Determines if the ALB is internal. Default: false"
  default = false
}
*/
