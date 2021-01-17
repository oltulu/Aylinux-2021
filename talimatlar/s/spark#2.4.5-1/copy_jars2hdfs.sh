#!/bin/sh
# spark execution engine for hive on remote mode
$HADOOP_HOME/bin/hadoop fs -rm -skipTrash /spark-jars/*
$HADOOP_HOME/bin/hadoop fs -put /usr/mdp/spark/jars/*.jar /spark-jars/
