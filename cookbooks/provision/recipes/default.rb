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
    image_id: "ami-97785bed", # Amazon Linux AMI 2017.09.1 (HVM), SSD Volume Type
    instance_type: "t2.micro",
    key_name: "salsify-elastic-pub",
    key_path: "/Users/jim/git/salsify-elasticsearch/.chef/salsify-elastic.pem",
  },
  use_private_ip_for_ssh: true,
  transport_address_location: :public_ip,
  ssh_username: "ec2-user",
  sudo: true,
})

machine 'elastic-node1' do
  run_list ['provision::elastic']
end
