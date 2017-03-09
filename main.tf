### ALB resources

# TODO:
# need health check
# internal or external
# with logging or without logging (perhaps even submodule locally?)

resource "aws_alb" "main" {
  name            = "${var.alb_name}"
  subnets         = ["${split(",", var.subnets)}"]
  security_groups = ["${split(",", var.alb_security_groups)}"]

  /*
      access_logs {
        bucket        = "${var.log_bucket}"
        prefix = "${var.log_prefix}"
      }*/
  count = 1
}

resource "aws_alb_target_group" "target_group" {
  name     = "${var.alb_name}-tg"
  port     = "${var.backend_port}"
  protocol = "${upper(var.backend_protocol)}"
  vpc_id   = "${var.vpc_id}"
}

# add listeners using count based on http/https vars
resource "aws_alb_listener" "front_end_http" {
  load_balancer_arn = "${aws_alb.main.id}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.target_group.id}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "front_end_https" {
  load_balancer_arn = "${aws_alb.main.id}"
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = "${var.certificate_arn}"
  ssl_policy        = "ELBSecurityPolicy-2015-05"

  default_action {
    target_group_arn = "${aws_alb_target_group.target_group.id}"
    type             = "forward"
  }
}

/*
resource "aws_elb" "elb" {
  name            = "${var.elb_name}"
  subnets         = ["${split(",", var.subnet_azs)}"]
  internal        = "${var.elb_is_internal}"
  security_groups = ["${split(",", var.elb_security_groups)}"]

  access_logs {
    bucket        = "${var.log_bucket}"
    bucket_prefix = "${var.log_prefix}"
    interval      = 5
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "${var.health_check_target}"
    interval            = 30
  }

  cross_zone_load_balancing = true

  tags {
    Name            = "${var.name}"
    App             = "${var.app}"
    Creator         = "${var.creator}"
    Group           = "${var.group}"
    Environment     = "${var.environment_tag}"
    Ops_Environment = "${var.operational_environment}"
  }
}

resource "aws_lb_cookie_stickiness_policy" "http_stickiness" {
  name                     = "httpstickiness"
  load_balancer            = "${aws_elb.elb.id}"
  lb_port                  = 80
  cookie_expiration_period = 600
  depends_on               = ["aws_elb.elb"]
}

resource "aws_lb_cookie_stickiness_policy" "https_stickiness" {
  name                     = "httpsstickiness"
  load_balancer            = "${aws_elb.elb.id}"
  lb_port                  = 443
  cookie_expiration_period = 600
  depends_on               = ["aws_elb.elb"]
}
*/

