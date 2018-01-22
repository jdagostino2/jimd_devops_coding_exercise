name 'elasticdeploy'
maintainer 'The Authors'
maintainer_email 'you@example.com'
license 'All Rights Reserved'
description 'Installs/Configures elasticdeploy'
long_description 'Installs/Configures elasticdeploy'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)
depends 'elasticsearch', '>= 2.0.0'
depends 'java8'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/elasticdeploy/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/elasticdeploy'
