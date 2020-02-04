#!/bin/bash
# 安装docker 

echo "start to dowload docker...."
if [ -a "docker-18.03.1-ce.tgz" ];then
        echo "found docker install file"
else
        echo "can't find docker install file"
        yum install -y wget 
        wget https://download.docker.com/linux/static/stable/x86_64/docker-18.03.1-ce.tgz
fi

tar -xvf docker-18.03.1-ce.tgz
chmod +x docker-18.03.1-ce/*
cp docker-18.03.1-ce/* /usr/local/bin/
cat > /usr/lib/systemd/system/docker.service <<"EOF"
[Unit]
Description=Docker Application Container Engine
Documentation=http://docs.docker.io

[Service]
Environment="PATH=/usr/local/bin:/bin:/sbin:/usr/bin:/usr/sbin"
EnvironmentFile=-/run/flannel/docker
ExecStart=/usr/local/bin/dockerd --log-level=error $DOCKER_NETWORK_OPTIONS
ExecReload=/bin/kill -s HUP $MAINPID
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
# 国内dockerhub加速   
cat <<'EOF' > /etc/docker/daemon.json
{
"registry-mirrors": ["https://registry.docker-cn.com"]
}
EOF

systemctl restart docker
systemctl enable docker

