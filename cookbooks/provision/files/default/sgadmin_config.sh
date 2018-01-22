#!/bin/bash
sudo /usr/share/elasticsearch/plugins/search-guard-5/tools/sgadmin.sh -cd /usr/share/elasticsearch/plugins/search-guard-5/sgconfig -icl -ks /etc/elasticsearch/kirk.jks -ts /etc/elasticsearch/truststore.jks -nhnv
