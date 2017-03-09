# tf_aws_alb

A Terraform module containing common configurations for an AWS Application Load
Balancer (ALB) running over HTTP/HTTPS.

## Assumptions

* *You want to associate the ASG with a target group and ALB*
* You've created a Virtual Private Cloud (VPC) + subnets where you intend to put
this ALB and backing instances.
* You can fully bootstrap your instances using an AMI + user_data.
* You want to configure a listener for HTTPS
* You've uploaded an SSL certificate to AWS/IAM

The module supports both (mutually exclusive):
* Internal IP ALBs
* External IP ALBs

It's recommended you use this module with
[sg_https_only](https://github.com/terraform-community-modules/tf_aws_sg/tree/master/sg_https_only#sg_https_only-terraform-module) and [tf_aws_asg_elb](https://github.com/terraform-community-modules/tf_aws_asg_elb)

## Why ALB instad of ELB?
Admittedly, the use-case appears almost identical to how one would use an ELB
BUT we inherit a few bonuses by moving to ALB. Those are best outlined in [AWS's
documentation](https://aws.amazon.com/elasticloadbalancing/applicationloadbalancer/).
For an example of using ALB with ECS look no further than the [hashicorp example](https://github.com/hashicorp/terraform/tree/master/examples/aws-ecs-alb).

## Input Variables
---------------
* `alb_is_internal` - Determines if the ALB is externally facing or internal. (Optional; default: false)
* `alb_name` - Name of the ALB as it appears in the AWS console. (Optional; default: my_alb)
* `alb_protocols` - A comma delimited list of protocols the ALB will accept for incoming connections. Only HTTP and HTTPS are supported. (Optional; default: HTTPS)
* `alb_security_groups` - A comma delimited list of security groups to attach to the ALB. (Required)
* `backend_port` - Port on which the backing instances serve traffic. (Optional; default: 80)
* `backend_protocol` - Protocol the backing instances use. (Optional; default: HTTP)
* `certificate_arn` - . (Required if using HTTPS in `alb_protocols`)
* `cookie_duration` - If sticky sessions via cookies are desired, set this variable to a value from 2 - 604800 seconds. (Optional)
* `health_check_path` - Path for the load balancer to health check instances. (Optional; default: /)
* `log_bucket` - S3 bucket where access logs should land. (Required)
* `log_prefix` - S3 prefix within the `log_bucket` where logs should land. (Optional)
* `subnets` - ALB will be created in the subnets in this list. (Required)
* `vpc_id` - Resources will be created in the VPC with this `id`. (Required)

## Outputs
-------
* `alb_id` - `id` of the ALB created.
* `alb_dns_name` - DNS CNAME of the ALB created.
* `alb_zone_id` - Route53 `zone_id` of the newly minted ALB.
* `target_group_arn` - `arn` of the target group. Useful for passing to your Auto Scaling group module.

## Usage example:
A full example set is contained in the [example directory](example/). Here's the gist:
1. Set the input variables from above in [variables.tf](example/variables.tf).
2. Define the ALB module using the following in your [main.tf](example/main.tf):
```
module "alb" {
  source              = "github.com/brandoconnor/tf_aws_alb"
  alb_security_groups = "${var.security_group_id_list}"
  log_bucket          = "${var.log_bucket}"
  subnets             = "${var.subnet_id_list}"
  vpc_id              = "${var.vpc_id}"
}
```
3. Always `terraform plan` to see your change before running `terraform apply`.
4. Win the day!

## Contributing
Report issues/questions/feature requests on in the [Issues](https://github.com/brandoconnor/tf_aws_alb/issues) section.

Pull requests are welcome! Ideally create a feature branch and issue for every
individual change you make. These are the steps:

1. Fork the repo.
2. Create your feature branch from master (`git checkout -b my-new-feature`).
4. Commit your awesome changes (`git commit -am 'Added some feature'`).
5. Push to the branch (`git push origin my-new-feature`).
6. Create a new Pull Request and tell us about your changes.

## Change log
The [Change log](CHANGELOG.md) captures all important release notes.

## Authors
Created and maintained by [Brandon O'Connor](https://github.com/brandoconnor) - brandoconnor@gmail.com.

## License
MIT Licensed. See [LICENSE](LICENSE) for full details.
