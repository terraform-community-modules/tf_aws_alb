require 'awspec'

control 'local_security_group' do
  describe 'the security group' do
    # let(:example_security_group) { security_group 'kitchen-terraform-example' }
    let(:example_security_group) { security_group 'sg-b4aa91cc' }

    # describe 'ingress' do
    #   subject { example_security_group.inbound }
    #
    #   it('is open to the world') { is_expected.to be_opened.for '0.0.0.0/0' }
    # end

    describe 'egress' do
      subject { example_security_group.outbound }

      it('is open to the world') { is_expected.to be_opened.for '0.0.0.0/0' }
    end
  end
end
