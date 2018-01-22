#
# Cookbook:: provision
# Recipe:: default
#
# Copyright:: 2018, Jim D'Agostino, All Rights Reserved.

require 'chef/provisioning'
require 'chef/provisioning/aws_driver'

with_driver 'aws::us-east-1'

with_machine_options({
  bootstrap_options: {
    #image_id: "ami-97785bed", # Amazon Linux AMI 2017.09.1 (HVM), SSD Volume Type
    image_id: "ami-428aa838", # Amazon Linux 2 LTS Candidate AMI 2017.12.0 (HVM), SSD Volume Type
    instance_type: "t2.small",
    key_name: "salsify-elastic-pub",
    key_path: "/home/vagrant/.chef/keys/salsify-elastic-pub.pem",
  },
  start_timeout: 600,
  use_private_ip_for_ssh: true,
  transport_address_location: :public_ip,
  ssh_username: "ec2-user",
  sudo: true,
})

machine 'elasticnode1' do
  run_list ['provision::elastic']
end

machine 'elasticnode2' do
  run_list ['provision::elastic']
end
