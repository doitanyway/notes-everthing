#!/bin/bash

# 错误退出  
set -e

echo "Check the Neo4J file...."
if [ -a "neo4j-community-"*"-unix.tar.gz" ];then
        echo "found Neo4J install file"
else
        ehco "download : neo4j-community-4.0.0-unix.tar.gz"
        echo "If you can't access the internet. You can download it in you desktop and upload to the server."
        echo "Baidu cloud: https://pan.baidu.com/s/1ztST5FltyQHMPwOe1d65zQ  Code:y3z3"
        echo "Offical website: http://dist.neo4j.org/neo4j-community-4.0.0-unix.tar.gz"
        yum install -y curl
        curl -O http://dist.neo4j.org/neo4j-community-4.0.0-unix.tar.gz
fi


APP_HOME=/apps
mkdir -p $APP_HOME
rm -rf ${APP_HOME}/neo4j* 
tar -xzvf neo4j-community-*-unix.tar.gz -C /apps/
ln -s ${APP_HOME}/neo4j-community-*  ${APP_HOME}/neo4j

sed -i '/NEO4J_HOME_VAR/'d /etc/profile 
sed -i '/NEO4J_HOME_PATH/'d /etc/profile 

echo "export NEO4J_HOME=${APP_HOME}/neo4j   # NEO4J_HOME_VAR"  >> /etc/profile
echo "export PATH=\$NEO4J_HOME/bin:\$PATH         # NEO4J_HOME_PATH"  >> /etc/profile
source /etc/profile

neo4j --version


cat > /usr/lib/systemd/system/neo4j.service <<"EOF"
[Unit]
Description=Neo4J Application Container Engine
Documentation=https://neo4j.com

[Service]
Environment="PATH=/usr/local/bin:/bin:/sbin:/usr/bin:/usr/sbin:/apps/jdk/bin:/apps/neo4j/bin"
ExecStart=/apps/neo4j/bin/neo4j start
ExecReload=/apps/neo4j/bin/neo4j reload
Restart=on-failure 
RestartSec=5
LimitNOFILE=infinity
LimitNPROC=infinity
LimitCORE=infinity
Delegate=yes
KillMode=process

[Install]
WantedBy=multi-user.target
EOF

# http监听地址，0.0.0.0 所有网卡    
sed -i "s/^#dbms.connectors.default_listen_address.*/dbms.connectors.default_listen_address=0.0.0.0/g"  \
        ${APP_HOME}/neo4j/conf/neo4j.conf

systemctl daemon-reload
systemctl enable neo4j
systemctl start neo4j

