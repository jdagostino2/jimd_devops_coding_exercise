# provision

Leverages AWS Provision driver to build AWS Nodes and bootstrap with Chef.
Runs elastic recipe to perform post build steps to install ElasticSearch.

- 'recipe[provision::default]' <- AWS Provision
- 'recipe[provision::topo]' <- Define your systems
- 'recipe[provision::elastic]' <- Install Java & ElasticSearch w/ Plugins.
