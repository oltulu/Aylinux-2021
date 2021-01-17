#!/bin/sh
sed -i '/<module>hadoop-cloud-storage-project<\/module>/d' pom.xml 
sed -i '/<module>hadoop-project<\/module>/d' pom.xml 
sed -i '/<module>hadoop-tools<\/module>/d' pom.xml 

sed -i '/<module>hadoop-aws<\/module>/d' hadoop-tools/pom.xml 
sed -i '/<module>hadoop-openstack<\/module>/d' hadoop-tools/pom.xml 
sed -i '/<module>hadoop-sls<\/module>/d' hadoop-tools/pom.xml 
sed -i '/<module>hadoop-azure<\/module>/d' hadoop-tools/pom.xml 
sed -i '/<module>hadoop-aws<\/module>/d' hadoop-tools/pom.xml 
sed -i '/<module>hadoop-kafka<\/module>/d' hadoop-tools/pom.xml 
sed -i '/<module>hadoop-azure-datalake<\/module>/d' hadoop-tools/pom.xml 
sed -i '/<module>hadoop-aliyun<\/module>/d' hadoop-tools/pom.xml 
sed -i '/<module>hadoop-streaming<\/module>/d' hadoop-tools/pom.xml 
