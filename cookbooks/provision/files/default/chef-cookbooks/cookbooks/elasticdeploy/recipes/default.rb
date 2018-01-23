#
# Cookbook:: elasticconfig
# Recipe:: default
#
# Copyright:: 2018, Jim D'Agostino, All Rights Reserved.

# Create the default user.
elasticsearch_user 'elasticsearch'

# Install ES, pin to version below.
elasticsearch_install 'elasticsearch' do
  version '5.6.6-1'
  action :install
end

# Configure ES with mostly defaults, set mem and cluster name.
elasticsearch_configure 'elasticsearch' do
    allocated_memory '512m'
    configuration ({
      'cluster.name' => 'salsify-cluster01',
    })
end

# Enable on boot, start service.
elasticsearch_service 'elasticsearch' do
  service_actions [:enable, :start]
end

# Install and enable the EC2 Discovery Plugin.
elasticsearch_plugin 'discovery-ec2' do
  action :install
  notifies :restart, 'elasticsearch_service[elasticsearch]', :delayed
  not_if { ::File.directory?("/usr/share/elasticsearch/plugins/discovery-ec2") }
end

# Install and enable the Search Guard Plugin.
elasticsearch_plugin 'com.floragunn:search-guard-5:5.6.6-18' do
  action :install
  notifies :restart, 'elasticsearch_service[elasticsearch]', :delayed
  not_if { ::File.directory?("/usr/share/elasticsearch/plugins/search-guard-5") }
end
