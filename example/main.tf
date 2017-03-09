module "external_alb" {
  /*source              = "github.com/brandoconnor/tf_aws_alb"*/
  source              = "../"
  alb_name            = "${var.alb_name}"
  backend_port        = "${var.instance_port}"
  backend_protocol    = "${var.instance_protocol}"
  health_check_target = "${var.health_check_target}"
  alb_security_groups = "${join(",", var.security_group_id_list)}"
  log_bucket          = "${var.log_bucket_name}-${var.aws_region}"
  log_prefix          = "${var.log_prefix}"
  ssl_certificate_id  = "${var.ssl_cert_arn}"
  subnet_azs          = "${join(",", var.public_subnet_ids)}"
}
