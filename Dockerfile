FROM qnib/d-terminal:squeeze

ADD etc/apt/sources.list.d/cloudera.list /etc/apt/sources.list.d/
RUN curl -s archive.key http://archive.cloudera.com/cdh4/debian/squeeze/amd64/cdh/archive.key | apt-key add - && \
    apt-get update
RUN apt-get install -y --force-yes apt-utils
# Carve this out for different host types
## JobTracker host
RUN apt-get install -y hadoop-0.20-mapreduce-jobtracker
## NameNode
RUN apt-get install -y hadoop-hdfs-namenode
## ??
RUN apt-get install -y hadoop-0.20-mapreduce-tasktracker hadoop-hdfs-datanode
