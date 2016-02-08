#!/bin/bash

sleep 5
if [ ! -d /data/hadoopdata/hdfs/datanode/ ];then
    mkdir -p /data/hadoopdata/hdfs/datanode/
    chown hdfs: -R /data/hadoopdata/hdfs/datanode
fi

consul-template -consul localhost:8500 -once -template /etc/consul-templates/hdfs/core-site.xml.ctmpl:/etc/hadoop/conf/core-site.xml

su -c '/usr/bin/hadoop datanode' hdfs

