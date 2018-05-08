# 安装docker

## 在mac 上安装docker
参考：https://docs.docker.com/docker-for-mac/install/

* 下载docker安装文件：[稳定版](https://download.docker.com/mac/stable/Docker.dmg),[最新版](https://download.docker.com/mac/edge/Docker.dmg)
* 安装运行docker  
![](./assets/2018-02-17-08-57-08.png)
* 申请自己的docker id，登陆；

## 在windows上安装docker
参考： https://docs.docker.com/docker-for-windows/install/

## 在centos 上安装docker

* 官方参考：https://docs.docker.com/install/linux/docker-ce/centos/
```
 示例rpm包安装：
 1.新建文件夹： mkdir /home/software
 2.下载rpm包：wget https://download.docker.com/linux/centos/7/x86_64/stable/Packages/docker-ce-18.03.0.ce-1.el7.centos.x86_64.rpm   
 3.yum安装rpm：yum install /path/to/docker-ce-18.03.0.ce-1.el7.centos.x86_64.rpm
 4.启动docker:systemctl start docker
 5.测试安装是否成功： 
   docker run hello-world  ##会自动下载hello-world镜像
```

## docker 加速

* 由于国内网络原因，DOCKER访问docker hub经常超时，为了能够给DOCKER加速，我们可使用国内DOCKER镜像；``vi /etc/docker/daemon.json ``

```json
{
"registry-mirrors": [ "你的阿里云加速地址"]
}
```
* 如何查看你的阿里云加速地址
```
1.你得首先注册阿里云账号
2.进入https://cr.console.aliyun.com/#/accelerator