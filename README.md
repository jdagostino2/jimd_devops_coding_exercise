# Build a Secure Cloud ElasticSearch Instance
Leverage Chef and the **[chef-provisioning-aws](https://github.com/chef/chef-provisioning-aws)** driver to build any number of machines and automatically configure them for use with ElasticSearch.

Chef has been selected for this project to show the full power of Chef and how it can be used for system provisioning and configuration management. Using only Chef cuts down on the number of application dependencies, making it easy to bundle the code as an all-in-one solution. In a production environment there would be various other tools incorporated into this design to make the solution more robust and scalable.  

The following items are performed during the chef convergence:
 - Deploy EC2 system from desired AMI.
 - Bootstrap EC2 node with Chef for local cookbook execution.
 - Install Java 8.
 - Install and configure Elasticsearch.
 - Install [Search Guard](https://github.com/floragunncom/search-guard) Elasticsearch plugin and configure for secure connections.
 - Install [EC2 Discovery Plugin](https://www.elastic.co/guide/en/elasticsearch/plugins/current/discovery-ec2.html).

# Prerequisites
Before getting started you will need to configure your workspace with following applications and configurations.
**Required Software**
 - [Chef Development Kit](https://downloads.chef.io/chefdk).
 - [AWS Command Line Interface](https://aws.amazon.com/cli/).
 - [Git](https://git-scm.com/downloads)

**Required Configurations**
 - AWS Access Keys saved to .aws, or exported in working session.
>     $ cat ~/.aws/credentials
>     [default]
>     aws_access_key_id = KEYHERE
>     aws_secret_access_key = SECRETKEYHERE
- AWS Keypair saved to .chef/keys.
Private key must be mode 400.
>     $ ls ~/.chef/keys/
>     salsify-elastic.pem	   salsify-elastic.pub
- AWS Keypair added to default runbook.
>    vim cookbooks/provision/recipes/default.rb
>    key_name: "salsify-elastic",
>    key_path: "~/.chef/keys/salsify-elastic.pem",
- Local copy of git repo.
> git clone git@github.com:jdagostino2/jimd_devops_coding_exercise.git
- Chef client.rb configuration.
>     $ cat .chef/client.rb
>     #General
>     current_dir = File.dirname(__FILE__)
>     log_level                :info
>     log_location             STDOUT
>     node_name                "provisioner"
>     client_key               "#{current_dir}/dummy.pem"
>     validation_client_name   "validator"
>     #AWS
>     driver 'aws:us-east-1'
>     driver_options :compute_options => { 	
>       :aws_access_key_id => 'KEYHERE', 	
>       :aws_secret_access_key => 'SECRETKEYHERE', 	
>       :region => 'us-east-1', 	
>       :ssh_user => 'ec2-user'

## Running Code
Once all the Prerequisites have been met you're ready to build your machines.

 1. Edit the topo.rb file if you wish to change the default number of systems to build (default: 2).

>     $ vim cookbooks/provision/recipes/topo.rb
>     machine 'elasticnode1' do  
>     run_list ['provision::elastic']
>     end
 - Run the Chef-Client in local mode inputing the provision recipe.
>     sudo chef-client -z -r 'recipe[provision]' --listen Starting Chef
>        Client, version 13.6.4 resolving cookbooks for run list: ["provision"]
>        Synchronizing Cookbooks: {OUTPUT CUT} [2018-01-23T00:59:58-05:00]
>        INFO: Chef Run complete in 99.91546 seconds
## Validate Systems
Once the systems are fully provisioned and converged you will be able to validate that elasticsearch is working by running the following example CURLs.

*NOTE:  The default admin password has been changed. Please email JDAgostino2@gmail.com if you need the default password. The password can always be changed in the **sg_internal_users.yml** file.*
 - Check Cluster Health.
>     $ curl --insecure -u admin:PASS 'https://ipaddress:9200/_cluster/health?pretty'
>     {   
>       "cluster_name" : "salsify-cluster01",   
>       "status" : "green",   
>       "timed_out" : false,  
>       "number_of_nodes" : 1,   
>       "number_of_data_nodes" : 1,  
>       "active_primary_shards" : 1,   
>       {OUTPUT CUT}
>     }

 - Check that Search Guard is up and running.
>      $ curl --insecure -u admin:PASS 'https://ipaddress:9200/_searchguard/authinfo?pretty'
>     {
>       "user" : "User [name=admin, roles=[]]",
>       "user_name" : "admin",
>       "user_requested_tenant" : null,
>       "remote_address" : "98.118.89.189:52410", 		
>       {OUTPUT CUT}
>     }
**NOTE : NOTE : NOTE **
There has been a few times that the **sgadmin_config.sh** script doesn't run and results in Search Guard not being fully configured. To resolve this run the following command:
 >  ssh -i ~/.chef/keys/your-key.pem ec2-user@ipaddress /home/ec2-user/sgadmin_config.sh

## Resources
**Public Cookbooks**
 - [cookbook/elasticsearch](https://github.com/elastic/cookbook-elasticsearch)
 - [agileorbit-cookbooks/java](https://github.com/agileorbit-cookbooks/java)
 - [shekhargulati/java8-chef-cookbook](https://github.com/shekhargulati/java8-chef-cookbook)

**Articles**
 - [Getting Started with Chef-Provisioning](https://christinemdraper.wordpress.com/2015/01/31/deploying-a-multi-node-application-to-aws-using-chef-provisioning/)
 - [Deploying Elasticsearch 2.0.0 with Chef](https://www.elastic.co/blog/deploying-elasticsearch-200-with-chef)
 - [Chef Provisioning: Chef All the Things - ChefConf 2015](https://www.youtube.com/watch?v=LTTejR-5dIU&t=627s)

## Feedback

 - I did want to get to the 3 node cluster "Extra Credit" task, but due to time limitations due to travel this past weekend I am not able to complete that at this time. The nodes are configured to install the discovery-ec2 during their bootstrap, so finishing up the config will not take much longer.
