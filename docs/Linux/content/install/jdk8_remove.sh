#!/bin/bash
# delete jdk

JAVA_HOME_VAR=/apps
sed -i '/JAVA_HOME_VAR/'d /etc/profile 
sed -i '/JAVA_HOME_PATH/'d /etc/profile 
rm -rf ${JAVA_HOME_VAR}/jdk*
source /etc/profile