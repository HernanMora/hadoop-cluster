#!/bin/bash
rm /tmp/*.pid

/etc/configure.sh

service ssh start

$HADOOP_HOME/sbin/start-dfs.sh
$HADOOP_HOME/sbin/start-yarn.sh 

while true; do sleep 1000; done