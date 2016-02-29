#!/usr/local/bin/dumb-init /bin/bash

sleep 5
if [ ! -d /data/hadoopdata/hdfs/datanode/ ];then
    mkdir -p /data/hadoopdata/hdfs/datanode/
    chown hdfs: -R /data/hadoopdata/hdfs/datanode
fi

if [ "X${HADOOP_HDFS_NAMENODE}" != "Xtrue" ];then
    consul-template -consul localhost:8500 -once -template /etc/consul-templates/hdfs/core-site.xml.ctmpl:/etc/hadoop/conf/core-site.xml
fi
if [ ! -f /etc/hadoop/conf/hdfs-site.xml ];then
    consul-template -consul localhost:8500 -once -template /etc/consul-templates/hdfs/hdfs-site.xml.ctmpl:/etc/hadoop/conf/hdfs-site.xml
fi

su -c '/usr/bin/hadoop datanode' hdfs

