variable "aws_region" {
  default = "us-west-2"
}

variable "alb_name" {
  default = "example_alb"
}

variable "security_group_id_list" {
  default = ["sg-edcd9784", "sg-edcd9785"]
}

variable "certificate_arn" {
  default = "arn:aws:iam::123456789012:server-certificate/ProdServerCert"
}

variable "public_subnet_ids" {
  default = ["subnet-1a2b3c4d", "subnet-1a2b3c4e", "subnet-1a2b3c4f"]
}

variable "instance_port" {
  default = "8080"
}

variable "instance_protocol" {
  default = "HTTPS"
}

variable "health_check_target" {
  default = "HTTPS:443/health"
}

variable "log_bucket_name" {
  default = "my_log_bucket"
}

variable "log_prefix" {
  default = "example_alb"
}

variable "vpc_id" {
  default = "vpc-12345678"
}
