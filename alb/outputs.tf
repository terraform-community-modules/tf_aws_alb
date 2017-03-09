# this approach is not working just yet
output "arn" {
  value = "${coalesce(aws_alb.alb_loging.arn, aws_alb.alb_nologing.arn) }"

  /*value = "${aws_alb.alb_loging.arn}"*/
}

output "dns_name" {
  value = "${aws_alb.alb_loging.dns_name}"

  /*value = "${coalesce(list("aws_alb.alb_loging.dns_name", "aws_alb.alb_nologing.dns_name")) }"*/
}

output "id" {
  value = "${aws_alb.alb_loging.id}"

  /*value = "${coalesce(list("aws_alb.alb_loging.dns_name", "aws_alb.alb_nologing.dns_name")) }"*/
}

output "zone_id" {
  value = "${aws_alb.alb_loging.zone_id}"

  /*value = "${coalesce(list("aws_alb.alb_loging.dns_name", "aws_alb.alb_nologing.dns_name")) }"*/
}
