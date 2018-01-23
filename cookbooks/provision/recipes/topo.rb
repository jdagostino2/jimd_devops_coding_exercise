#
# Cookbook:: provision
# Recipe:: topo
#
# Copyright:: 2018, Jim D'Agostino, All Rights Reserved.

# Setup and build the following machines.
machine 'elasticnode1' do
  run_list ['provision::elastic']
  aws_tags app: 'elastic_search'
end

machine 'elasticnode2' do
  run_list ['provision::elastic']
  aws_tags app: 'elastic_search'
end
