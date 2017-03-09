variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "aws_region" {
  default = "us-west-2"
}

variable "alb_name" {
  default = "example_alb"
}

variable "alb_security_groups" {
  default = ["sg-edcd9784", "sg-edcd9785"]
}

variable "ssl_certificate_id" {
  default = "arn:aws:iam::123456789012:server-certificate/ProdServerCert"
}

variable "subnets" {
  default = ["subnet-1a2b3c4d", "subnet-1a2b3c4e", "subnet-1a2b3c4f"]
}

variable "backend_port" {
  default = "8080"
}

variable "backend_protocol" {
  default = "http"
}

variable "health_check_target" {
  default = "HTTPS:443/health"
}

variable "log_bucket" {
  default = "my_log_bucket"
}

variable "log_prefix" {
  default = "example_alb"
}
