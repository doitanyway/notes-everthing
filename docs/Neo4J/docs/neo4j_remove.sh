#!/bin/bash

systemctl daemon-reload
systemctl stop neo4j
rm -rf /usr/lib/systemd/system/neo4j.service
rm -rf /apps/neo4j*

sed -i '/NEO4J_HOME_VAR/'d /etc/profile 
sed -i '/NEO4J_HOME_PATH/'d /etc/profile 
source /etc/profile


