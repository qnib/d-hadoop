#!/bin/bash

if [ ! -d /data/hadoopdata/hdfs/namenode ];then
    mkdir -p /data/hadoopdata/hdfs/namenode
    hdfs namenode -format
    chown hdfs: -R /data/hadoopdata/hdfs
fi

su -c '/usr/bin/hadoop namenode' hdfs

