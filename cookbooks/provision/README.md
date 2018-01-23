# provision

Leverages AWS Provision driver to build AWS Nodes and bootstrap with Chef.
Runs elastic recipe to perform post build steps to install ElasticSearch.

- 'recipe[provision::default]' <- AWS Provision
- 'recipe[provision::topo]' <- Define your systems
- 'recipe[provision::elastic]' <- Install Java & ElasticSearch w/ Plugins.

Additional cookbooks will be found under files/default.

- 'recipe[elasticdeploy::default]' <-- ElasticSearch Application Configure.
- 'recipe[elasticdeploy::searchguard]' < - Post config of Search Guard Plugin.
