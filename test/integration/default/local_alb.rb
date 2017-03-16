require 'awspec'
require 'parseconfig'

terraform_tfvars_config = ParseConfig.new('test/fixtures/terraform.tfvars')
log_bucket = terraform_tfvars_config.params['log_bucket']
log_prefix = terraform_tfvars_config.params['log_prefix']
aws_account_id = terraform_tfvars_config.params['aws_account_id']
tf_state = JSON.parse(File.open('.kitchen/kitchen-terraform/default-aws/terraform.tfstate').read)
principle_account_id = tf_state['modules'][0]['outputs']['principle_account_id']['value']
vpc_id = tf_state['modules'][0]['outputs']['vpc_id']['value']

describe alb('my-alb') do
  it { should exist }
  its (:load_balancer_name) {should eq 'my-alb'}
  its (:vpc_id) {should eq vpc_id}
  its (:type) {should eq 'application'}
  its (:scheme) {should eq 'internet-facing'}
  its (:ip_address_type) {should eq 'ipv4'}
end

describe s3_bucket(log_bucket) do
  it { should exist }
    it do
    should have_policy <<-POLICY
{
    "Version": "2012-10-17",
    "Id": "Policy1429136655940",
    "Statement": [
        {
            "Sid": "Stmt1429136633762",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::#{principle_account_id}:root"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::#{log_bucket}/#{log_prefix}/AWSLogs/#{aws_account_id}/*"
        }
    ]
}
    POLICY
  end
end
