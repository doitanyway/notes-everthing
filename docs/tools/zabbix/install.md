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
# docker pull zabbix/zabbix-appliance:alpine-4.4-latest
docker run -d --name some-zabbix-appliance  \
        -p 80:80 -p 10051:10051  \
        -e PHP_TZ=Asia/Shanghai \
        -v /home/mail.sh:/usr/lib/zabbix/alertscripts/mail.sh \
        -v /home/mysql_data:/var/lib/mysql \
        -v /home/zabbix/mail.rc:/etc/mail.rc \
        zabbix/zabbix-appliance:alpine-4.4-latest


docker run  --name some-zabbix-appliance  \
        -p 900:80 -p 10051:10051  \
        -e PHP_TZ=Asia/Shanghai \
        zabbix/zabbix-appliance:alpine-4.4-latest
```

* 在浏览器中输入地址``http://{ip_address}``,访问zabbix主页，如果能打开则安装成功。默认网页用户： Admin ，密码： zabbix


## yum安装zabbix-agent

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



## 二进制安装zabbix

* 创建用户  

```bash 
groupadd zabbix
# 新建zabbix用户并将其加入到zabbix组，并将他设置为不可登录的类型的用户
useradd -g zabbix zabbix -s /sbin/nologin  
```

* 选择对应版本的zabbix下载 https://www.zabbix.com/download_agents


* 安装 

```bash
mkdir -p /usr/local/zabbix
tar -xzvf  zabbix_agents-4.4.4-linux3.0-amd64-static.tar.gz -C /usr/local/zabbix


ln -s /usr/local/zabbix/bin/zabbix_sender /usr/local/zabbix/bin/zabbix_get /usr/bin

ln -s /usr/local/zabbix/sbin/zabbix_agentd /usr/sbin/
# ln -s  /usr/local/zabbix/bin/zabbix_get 

mv /usr/local/zabbix/conf/zabbix_agentd.conf  /usr/local/etc/


```


* 修改配置文件 ``vim /usr/local/etc/zabbix_agentd.conf``  

```bash
LogFile=/var/log/zabbix/zabbix_agentd.log
#地址主动模式,填写Server的IP
Server=127.0.0.1,10.200.203.31,10.200.203.28,10.200.203.26,10.200.203.25,10.200.203.23,10.200.203.21,10.200.203.15,10.200.203.13,10.200.203.62,10.200.203.59,10.200.203.6
#修改为Server的IP地址
ServerActive=127.0.0.1,10.200.203.31,10.200.203.28,10.200.203.26,10.200.203.25,10.200.203.23,10.200.203.21,10.200.203.15,10.200.203.13,10.200.203.62,10.200.203.59,10.200.203.6
#重要：客户端的hostname，不配置则使用主机名
# Hostname=Zabbix server    
```

* 创建文件赋权  
```BASH
mkdir -p /var/log/zabbix/
chown zabbix:zabbix /var/log/zabbix/
chmod 777 /var/log/zabbix/
touch /var/log/zabbix/zabbix_agentd.log
chmod 777 /var/log/zabbix/zabbix_agentd.log
```

* 修改文件``vim /etc/services``,末尾添加 

```bash
zabbix_agent 10050/tcp
zabbix_agent 10050/udp
```

* 初始化文件  
```bash 
cp /usr/local/zabbix/sbin/zabbix_agentd /etc/init.d
chmod a+x /etc/init.d/zabbix_agentd
touch  /tmp/zabbix_agentd.pid
chmod 777 /tmp/zabbix_agentd.pid
# 启动并检查zabbix是否启动
/etc/init.d/zabbix_agentd
ps -ef | grep zabbix  
```

* 验证安装是否成功

```
/usr/local/zabbix/bin/zabbix_get -s 127.0.0.1 -k "vfs.fs.size[/,total]"
```