provider "aws" {
  region = "${var.aws_region}"
}

module "alb" {
  source              = "../../alb/"
  alb_security_groups = "${var.alb_security_groups}"
  aws_account_id      = "${var.aws_account_id}"
  certificate_arn     = "${var.certificate_arn}"
  log_bucket          = "${var.log_bucket}"
  log_prefix          = "${var.log_prefix}"
  subnets             = "${var.subnets}"
  vpc_id              = "${var.vpc_id}"
}
