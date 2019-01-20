# zabbix 安装

## 前言

zabbix安装有很多方法，如源码安装、包安装、容器安装，本文介绍docker安装


## 安装server
#### 启动docker前准备
* 编写mail.sh脚本（用于发送邮件，docker容器中必须安装了mailx软件，$3、$2、$1参数后续说明）
```
#!/bin/sh
echo "$3" | mail -s "$2" $1
```
* mail.rc配置文件加上以下数据（定义谁来发送邮件，在容器中/etc/mail.rc复制出来的，方便后续修改）
```
set from=tttt@sohu.com 

set smtp=smtp.sohu.com

set smtp-auth-user=ttt@sohu.com 

set smtp-auth-password=ttt

set smtp-auth=login
```
* 创建mysql数据挂载文件夹，用于储存数据
```
mkdir /home/mysql_data
```
#### 启动docker
* 启动server docker 容器,如下命令启动了一个appliance版本的zabbix,其包含了MySQL server, Zabbix server, Zabbix Java Gateway and Zabbix frontend基于Nginx web-server

```bash
docker run -d --name some-zabbix-appliance  \
        -p 80:80 -p 10051:10051  \
        -e PHP_TZ=Asia/Shanghai \
        -v /home/mail.sh:/usr/lib/zabbix/alertscripts/mail.sh \
        -v /home/mysql_data:/var/lib/mysql \
        -v /home/zabbix/mail.rc:/etc/mail.rc \
        zabbix/zabbix-appliance:centos-4.0.3
```

* 在浏览器中输入地址``http://{ip_address}``,访问zabbix主页，如果能打开则安装成功。默认网页用户： Admin ，密码： zabbix


## 安装zabbix-agent

安装zabbix-agent安装在被监控电脑上


### 安装仓库配置包  

```
rpm -ivh http://repo.zabbix.com/zabbix/4.0/rhel/7/x86_64/zabbix-release-4.0-1.el7.noarch.rpm
```

### 安装软件
```
yum install zabbix-agent -y
```

### 配置zabbix-agent

编辑配置文件``/etc/zabbix/zabbix_agentd.conf``

```
#Server=[zabbix server ip]
#Hostname=[ Hostname of client system ]

Server=127.0.0.1,192.168.1.11
Hostname=Server1

ServerActive=192.168.1.11

# 监听地址，不设置则默认为10050
# ListenPort=10050

```

> Server填服务器ip，当zabbix server主动访问agent的时候需要是该地址，允许访问
>   '0.0.0.0/0' 能被所有的 IPv4 地址访问.
>    '::/0' 被所有的IPv4 或者 IPv6 地址访问.
注：

~1.服务器上使用命令‘hostname’查看hostname信息~


### 设置开机启动


```
systemctl start zabbix-agent
systemctl enable zabbix-agent
systemctl restart zabbix-agent
```

### [配置agent打开防火墙,端口，默认10050](https://github.com/doitanyway/notes-everything/blob/master/docs/Linux/content/iptables.md)

### 验证

* 登陆zabbix服务器容器，telnet 访问agent验证agent端口是否正常打开  

```
yum install -y telnet
telnet 192.168.50.4 10050
Trying 192.168.50.4...
Connected to 192.168.50.4.
Escape character is '^]'.
Connection closed by foreign host.
```

* 在客户端运行   

```
rpm -ivh http://repo.zabbix.com/zabbix/4.0/rhel/7/x86_64/zabbix-get-4.0.3-1.el7.x86_64.rpm
yum install zabbix-get
zabbix_get -s 127.0.0.1 -k "vfs.fs.size[/,total]"
```

* 如果服务器也安装了zabbix_get也可在服务器运行验证；

