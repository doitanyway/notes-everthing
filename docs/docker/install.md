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

* 执行如下脚本即可  

```bash 

# 安装docker
curl https://gitee.com/nickqiu/notes-everything/raw/master/docs/docker/install_docker.sh | bash  

# 安装docker-compose  
echo "start to dowload docker-compose...."
curl -L https://get.daocloud.io/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

```


### 指定容器运行根目录(可选)

```BASH
cat <<'EOF' >  /etc/docker/daemon.json
{
  "registry-mirrors" : [
    "https://registry.docker-cn.com"
  ],
  "data-root" : "/home/vagrant/data"
}
EOF

```


### 设置私有仓库方法(可选)  


```json 
cat <<'EOF'>/etc/docker/daemon.json
{
  "registry-mirrors" : [
    "https://registry.docker-cn.com"
  ],
  "insecure-registries" : [
    "20.250.204.146:6110"
  ]
}
EOF

```


##   登陆仓库

```
docker login -u name -p pasword 20.250.204.146:6110
```



