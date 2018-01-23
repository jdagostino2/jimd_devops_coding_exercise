#
# Cookbook:: elasticconfig
# Recipe:: searchguard
#
# Copyright:: 2018, Jim D'Agostino, All Rights Reserved.

# It's a long path, so lets var it up.
search_guard_pwd = "/usr/share/elasticsearch/plugins/search-guard-5"

# Copy the custom user database to the /sgconfig path.
file "#{search_guard_pwd}/sgconfig/sg_internal_users.yml" do
  owner 'root'
  group 'root'
  mode 0644
  content ::File.open("/home/ec2-user/sg_internal_users.yml").read
  action :create
end

# Add execute the the install script. 
file "#{search_guard_pwd}/tools/install_demo_configuration.sh" do
  mode '755'
end

# Run the install script and answer YES. 
execute 'install_demo_configuration' do
  user 'root'
  command "yes | #{search_guard_pwd}/tools/install_demo_configuration.sh"
  not_if "grep searchguard /etc/elasticsearch/elasticsearch.yml"
end

# Restart ES.
service 'elasticsearch' do
  action :restart
end

# Sleep and allow for elastic to start before last script.
Chef::Log.info("Delaying chef execution")
execute 'delay' do
  command 'sleep 5'
end

# Final step to enable Search Guard. 
execute 'sgadmin_config' do
  user 'ec2-user'
  ignore_failure true
  command "sudo su -i -c '/usr/share/elasticsearch/plugins/search-guard-5/tools/sgadmin.sh -cd /usr/share/elasticsearch/plugins/search-guard-5/sgconfig -icl -ks /etc/elasticsearch/kirk.jks -ts /etc/elasticsearch/truststore.jks -nhnv' -s /bin/sh root"
end
