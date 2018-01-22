#!/bin/bash
###############
# post.sh
# Quick script to setup and run remote chef-client
# Jim D'Agostino
###############

# Delete the old post dir if found
if [ -d /home/ec2-user/post ]; then
  sudo rm -Rf post
fi

# Extrac cookbook tar
tar xvf /home/ec2-user/post.tar.gz -C /home/ec2-user

cd /home/ec2-user/post

# Run both the Java and Elastic cookbooks.
chef-client -z --runlist 'recipe[java8]'
sleep 5

chef-client -z --runlist 'recipe[elasticdeploy]'
sleep 5

chef-client -z --runlist 'recipe[elasticdeploy::searchguard]'

log 'message' do
  message 'Install complete, please test!'
  level :info
end
