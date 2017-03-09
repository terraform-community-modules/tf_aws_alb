output "alb_id" {
  value = "${aws_alb.alb.id}"
}

output "alb_name" {
  value = "${aws_alb.alb.name}"
}

output "alb_dns_name" {
  value = "${aws_alb.alb.dns_name}"
}
