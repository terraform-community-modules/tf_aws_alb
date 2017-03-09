provider "aws" {
  allowed_account_ids = ["${var.aws_account_id}"]
  region              = "${var.aws_region}"
  access_key          = "${var.aws_access_key}"
  secret_key          = "${var.aws_secret_key}"
  region              = "${var.aws_region}"
}

module "alb" {
  source              = "github.com/brandoconnor/tf_aws_alb"
  alb_security_groups = "${var.security_group_id_list}"
  log_bucket          = "${var.log_bucket}"
  subnets             = "${var.subnet_id_list}"
  vpc_id              = "${var.vpc_id}"
}
