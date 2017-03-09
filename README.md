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
* `lc_name` - The launch configuration name

## Outputs
-------
- `alb_id`

## Usage example:
A full example set is contained in the [examples directory](examples/). Here's the gist:
1. Set the input variables from above in [variables.tf](examples/variables.tf).
2. Define the ALB module using the following in your [main.tf](examples/main.tf):
```
module "my_web_alb" {
  source = "github.com/brandoconnor/tf_aws_alb"
  alb_name = "${var.alb_name}"
  subnet_azs = "${var.subnet_azs}"
  backend_port = "${var.backend_port}"
  backend_protocol = "${var.backend_protocol}"
  ssl_certificate_id = "${var.ssl_certificate_id}"
  health_check_target = "${var.health_check_target}"
  aws_access_key = "${var.aws_access_key}"
  aws_secret_key = "${var.aws_secret_key}"
  aws_region = "${var.aws_region}"
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
MIT Licensed. See [LICENSE](LICENSE.md) for full details.
