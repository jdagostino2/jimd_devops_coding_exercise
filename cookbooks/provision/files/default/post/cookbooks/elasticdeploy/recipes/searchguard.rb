#
# Cookbook:: elasticconfig
# Recipe:: searchguard
#
# Copyright:: 2018, The Authors, All Rights Reserved.

#
search_guard_pwd = "/usr/share/elasticsearch/plugins/search-guard-5/"

#
file "#{search_guard_pwd}sgconfig/sg_internal_users.yml" do
  owner 'root'
  group 'root'
  mode 0644
  content ::File.open("/home/ec2-user/sg_internal_users.yml").read
  action :create
end

#
file "#{search_guard_pwd}/tools/install_demo_configuration.sh" do
  mode '755'
end

#
execute 'install_demo_configuration' do
  user 'root'
  command "yes | #{search_guard_pwd}/tools/install_demo_configuration.sh"
  notifies :restart, 'service[elasticsearch]', :immediately
end

#
service 'elasticsearch' do
  action :nothing
end

#
Chef::Log.info("Delaying chef execution")
execute 'delay' do
  command 'sleep 20'
end
#
execute 'sgadmin_config' do
  user 'root'
  command "/home/ec2-user/sgadmin_config.sh"
end
