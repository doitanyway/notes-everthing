# 安装docker

## 在mac 上安装docker
参考：https://docs.docker.com/docker-for-mac/install/

* 下载docker安装文件：[稳定版](https://download.docker.com/mac/stable/Docker.dmg), [最新版](https://download.docker.com/mac/edge/Docker.dmg)
* 安装运行docker  
![](./assets/2018-02-17-08-57-08.png)
* 申请自己的docker id，登陆；

## 在windows上安装docker
参考： https://docs.docker.com/docker-for-windows/install/

## 在centos 7 上安装docker


* 下载解压docker

```bash
wget https://download.docker.com/linux/static/stable/x86_64/docker-18.03.1-ce.tgz
tar -xvf docker-18.03.1-ce.tgz
```

> ``https://download.docker.com/linux/static/stable/x86_64/docker-17.03.2-ce.tgz``

* 拷贝二进制文件到指定目录

```bash 
chmod +x docker-18.03.1-ce/*
cp docker-18.03.1-ce/* /usr/local/bin
```
* 生成docker.service的文件并设定到/usr/lib/systemd/system目录下

```bash
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
systemctl restart docker    # 为了多次执行可以顺利使用restart
systemctl enable docker
```

* 结果确认``docker version``

* 安装docker-compose 
```
curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```

### 快速安装脚本
```bash 
#!/bin/bash
wget https://download.docker.com/linux/static/stable/x86_64/docker-18.03.1-ce.tgz
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
systemctl restart docker
systemctl enable docker

curl -L https://get.daocloud.io/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```


### 国内dockerhub加速

* 由于国内网络原因，DOCKER访问docker hub经常超时，为了能够给DOCKER加速，我们可使用国内DOCKER镜像：``vi /etc/docker/daemon.json ``

```
{
"registry-mirrors": ["https://registry.docker-cn.com"]
}
```

```bash 
systemctl daemon-reload 
systemctl restart docker
```


### 指定容器运行根目录(可选)

* vi /etc/docker/daemon.json

```json
{
  "registry-mirrors" : [
    "https://registry.docker-cn.com"
  ],
  "data-root" : "/home/vagrant/data"
}
```


### 设置私有仓库方法(可选)  

* ``vim /etc/docker/daemon.json ``

```json 

{
  "registry-mirrors" : [
    "https://registry.docker-cn.com"
  ],
  "insecure-registries" : [
    "20.250.204.146:6110"
  ]
}
```



##   登陆仓库

```
docker login -u name -p pasword 20.250.204.146:6110
```

