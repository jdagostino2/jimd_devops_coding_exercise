#
# Cookbook:: provision
# Recipe:: elastic
#
# Copyright:: 2018, Jim D'Agostino, All Rights Reserved.

file '/home/ec2-user/test.txt' do
    content 'This is a test'
    mode '0755'
    owner 'ec2-user'
    group 'ec2-user'
end

yum_package 'java' do
  action :install
end
