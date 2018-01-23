#
# Cookbook:: provision
# Recipe:: elastic
#
# Copyright:: 2018, Jim D'Agostino, All Rights Reserved.

##### COPY ALL THE FILES WE WILL NEED TO CONFIG ELASTIC ######

# Copy cookbooks needed on remote node.
remote_directory '/home/ec2-user/chef-cookbooks' do
  source 'chef-cookbooks'
  mode 0755
  owner 'ec2-user'
  group 'ec2-user'
end

# Secure Search Guard Config Script.
cookbook_file '/home/ec2-user/sgadmin_config.sh' do
  source 'sgadmin_config.sh'
  mode 0755
  owner 'ec2-user'
  group 'ec2-user'
end

# Updated user database with secure encrypted admin password.
cookbook_file "/home/ec2-user/sg_internal_users.yml" do
  source 'sg_internal_users.yml'
  mode 0644
  owner 'root'
  group 'root'
end

###### REMOTE EXECUTE COMMANDS TO CONFIGURE ELASTIC ######

execute 'Install Java 8' do
  user 'root'
  cwd '/home/ec2-user/chef-cookbooks'
  command "chef-client -z --runlist 'recipe[java8::default]'"
end

execute 'Install ElasticSearch' do
  user 'root'
  cwd '/home/ec2-user/chef-cookbooks'
  command "chef-client -z --runlist 'recipe[elasticdeploy::default]'"
end

execute 'Post Config SearchGuard' do
  user 'root'
  cwd '/home/ec2-user/chef-cookbooks'
  command "chef-client -z --runlist 'recipe[elasticdeploy::searchguard]'"
end

log 'message' do
  message 'Install complete, please test!'
  level :info
end
