#
# Cookbook:: provision
# Recipe:: elastic
#
# Copyright:: 2018, Jim D'Agostino, All Rights Reserved.

# 
cookbook_file '/home/ec2-user/post.tar.gz' do
  source 'post.tar.gz'
  mode '0755'
  owner 'ec2-user'
  group 'ec2-user'
end

# 
cookbook_file '/home/ec2-user/post.sh' do
  source 'post.sh'
  mode '0755'
  owner 'ec2-user'
  group 'ec2-user'
end

# 
cookbook_file '/home/ec2-user/sgadmin_config.sh' do
  source 'sgadmin_config.sh'
  mode '0755'
  owner 'ec2-user'
  group 'ec2-user'
end

# 
cookbook_file "/home/ec2-user/sg_internal_users.yml" do
  source 'sg_internal_users.yml'
  mode '0644'
  owner 'root'
  group 'root'
end

#
execute 'post_config' do
  user 'root'
  cwd '/home/ec2-user'
  command 'sudo ./post.sh'
end
