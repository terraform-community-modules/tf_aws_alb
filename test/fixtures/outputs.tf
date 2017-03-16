output "alb_id" {
  value = "${module.alb.alb_id}"
}

output "alb_dns_name" {
  value = "${module.alb.alb_dns_name}"
}

output "alb_zone_id" {
  value = "${module.alb.alb_zone_id}"
}

output "principle_account_id" {
  value = "${module.alb.principle_account_id}"
}

output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}
