# 安装docker

## 在mac 上安装docker
参考：https://docs.docker.com/docker-for-mac/install/

* 下载docker安装文件：[稳定版](https://download.docker.com/mac/stable/Docker.dmg), [最新版](https://download.docker.com/mac/edge/Docker.dmg)
* 安装运行docker  
![](./assets/2018-02-17-08-57-08.png)
* 申请自己的docker id，登陆；

## 在windows上安装docker
参考： https://docs.docker.com/docker-for-windows/install/

## 在centos 上安装docker

* 新建安装脚本``vim docker.sh``   ``chmod +x install.sh``

```shell
# bin/bash
rm -rf /usr/local/bin/docker-compose
sudo yum remove -y docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine

sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

sudo yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
sudo yum install -y docker-ce.x86_64 0:18.03.1.ce-1.el7.centos

curl -L https://get.daocloud.io/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```

## docker 加速

* 由于国内网络原因，DOCKER访问docker hub经常超时，为了能够给DOCKER加速，我们可使用国内DOCKER镜像：``vim /etc/docker/daemon.json ``

```json
{
"registry-mirrors": [ "https://registry.docker-cn.com"]
}
```

* 重启docker 

```
systemctl daemon-reload 
systemctl restart docker
```


## 设置私有仓库方法(可选)  

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

* 重启docker 

```
systemctl daemon-reload 
systemctl restart docker
```

* ``docker login 20.250.204.146:6110``

