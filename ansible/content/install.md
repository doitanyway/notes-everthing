## ansible安装

### 前言

本文介绍如何在centos 7上安装 ansible


### 安装

* 安装准备

```
# 文档中脚本默认均以root用户执行
# 安装 epel 源
yum install epel-release -y
# 安装依赖工具
yum install git python python-pip -y
```
* ansible安装,更改国内镜像

```
# 安装ansible (国内如果安装太慢可以直接用pip阿里云加速)
#pip install pip --upgrade
#pip install ansible
pip install pip --upgrade -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com
pip install --no-cache-dir ansible -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com
# 配置ansible ssh密钥登陆
ssh-keygen -t rsa -b 2048 回车 回车 回车
ssh-copy-id root@$IP 
```
> #$IP为需要控制机器的ip地址，按照提示输入yes 和root密码

### 验证

* 设置需控制的机器

> sudo vim /etc/ansible/hosts 

```
192.168.1.196 ansible_ssh_user=root
```

* 测试是否联通

```
fangleMac:~ fangle$ ansible all -m ping 
SSH password: 
192.168.1.196 | SUCCESS => {
    "changed": false, 
    "ping": "pong"
}
```

