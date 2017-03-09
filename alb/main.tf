### ALB resources with a switch - logging enabled/disabled

resource "aws_alb" "alb_loging" {
  name            = "${var.alb_name}"
  subnets         = ["${split(",", var.subnets)}"]
  security_groups = ["${split(",", var.alb_security_groups)}"]
  internal        = "${var.alb_is_internal}"

  access_logs {
    bucket = "${var.log_bucket}"
    prefix = "${var.log_prefix}"
  }

  count = "${var.log_bucket != "" && var.log_prefix != "" ? 1 : 0}"
}

resource "aws_alb" "alb_nologing" {
  name            = "${var.alb_name}"
  subnets         = ["${split(",", var.subnets)}"]
  security_groups = ["${split(",", var.alb_security_groups)}"]
  internal        = "${var.alb_is_internal}"

  count = "${(var.log_bucket == "" || var.log_prefix == "") ? 1 : 0}"
}
