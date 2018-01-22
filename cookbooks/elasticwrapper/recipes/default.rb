#
# Cookbook:: elasticwrapper
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

elasticsearch_user 'elasticsearch' do
  username 'elasticsearch'
  groupname 'elasticsearch'
  shell '/bin/bash'
  comment 'Elasticsearch User'
  action :create
end

elasticsearch_install 'elasticsearch' do
  type :package
end

elasticsearch_configure 'elasticsearch' do
  allocated_memory '256m'
  configuration ({
    'cluster.name' => 'mycluster',
    'node.name' => 'node01'
  })
end

elasticsearch_service 'elasticsearch' do
  service_actions [:enable, :start]
end

elasticsearch_plugin 'shield' do
  action :install
end
