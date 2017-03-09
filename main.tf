### Configure the provider

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

### ALB resources

resource "aws_alb_target_group" "test" {
  name     = "tf-example-ecs-ghost"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.main.id}"
}

resource "aws_alb" "main" {
  name            = "tf-example-alb-ecs"
  subnets         = ["${aws_subnet.main.*.id}"]
  security_groups = ["${aws_security_group.lb_sg.id}"]
}

resource "aws_alb_listener" "front_end" {
  load_balancer_arn = "${aws_alb.main.id}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.test.id}"
    type             = "forward"
  }
}

### Security

resource "aws_security_group" "lb_sg" {
  description = "controls access to the application ELB"

  vpc_id = "${aws_vpc.main.id}"
  name   = "tf-ecs-lbsg"

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
}

resource "aws_security_group" "instance_sg" {
  description = "Controls direct access to application instances."
  vpc_id      = "${aws_vpc.main.id}"
  name        = "${var.alb_name}-sg"

  ingress {
    protocol  = "tcp"
    from_port = "${var.backend_port}"
    to_port   = "${var.backend_port}"

    security_groups = [
      "${aws_security_group.alb_sg.id}",
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

/*
### ELB

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

  listener {
    instance_port      = "${var.backend_port}"
    instance_protocol  = "${var.backend_protocol}"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = "${var.ssl_certificate_id}"
  }

  listener {
    instance_port     = "${var.backend_port}"
    instance_protocol = "${var.backend_protocol}"
    lb_port           = 80
    lb_protocol       = "http"
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
