#!/bin/bash

# https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html


echo "check the jdk file...."
if [ -a "jdk-11"*"linux-x64"*".tar.gz" ];then
        echo "found jdk install file"
else
        echo "ERROR: can't find jdk 11 install file. Please download it in the following url. and run the command again."
        echo "Oracle: https://www.oracle.com/technetwork/java/javase/downloads/jdk11-downloads-5066655.html"
        echo "Baidu cloud: https://pan.baidu.com/s/1EgLncH-wOZdLpjya4xcHcA  Code:e7el"
        exit 1
fi


JAVA_HOME_VAR=/apps
rpm -qa|grep java | grep openjdk | grep -v grep | xargs -r yum -y remove
rpm -qa|grep java | grep openjdk | grep -v grep | xargs -r yum -y remove

mkdir -p $JAVA_HOME_VAR

tar -xzvf jdk-*-linux-x64.tar.gz -C /apps/
ln -s /apps/jdk* /apps/jdk

sed -i '/JAVA_HOME_VAR/'d /etc/profile 
sed -i '/JAVA_HOME_PATH/'d /etc/profile 

echo "export JAVA_HOME=${JAVA_HOME_VAR}/jdk   # JAVA_HOME_VAR"  >> /etc/profile
echo "export PATH=\$JAVA_HOME/bin:\$PATH   # JAVA_HOME_PATH"  >> /etc/profile

source /etc/profile
java -version