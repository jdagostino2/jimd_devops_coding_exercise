#
# Cookbook:: elasticconfig
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

elasticsearch_user 'elasticsearch'

elasticsearch_install 'elasticsearch' do
  version '5.6.6-1'
  action :install
end

elasticsearch_configure 'elasticsearch'

elasticsearch_service 'elasticsearch' do
  service_actions [:enable, :start]
end

elasticsearch_plugin 'discovery-ec2' do
  action :install
end

