#!/usr/local/bin/dumb-init /bin/bash

source /opt/qnib/consul/etc/bash_functions.sh

if [ "${HADOOP_HDFS_NAMENODE}" != "true" ];then
    rm -f /etc/consul.d/hdfs-namenode.json
    consul reload
    sleep 2
    exit 0
fi

## create initial namenode config
consul-template -consul localhost:8500 -once -template "/etc/consul-templates/hdfs/core-site.xml-INIT.ctmpl:/etc/hadoop/conf/core-site.xml"

if [ ! -d /data/hadoopdata/hdfs/namenode ];then
    mkdir -p /data/hadoopdata/hdfs/namenode
    hdfs namenode -format
    chown hdfs: -R /data/hadoopdata/hdfs
fi

su -c '/usr/bin/hadoop namenode' hdfs

