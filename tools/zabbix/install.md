# zabbix 安装 {ignore=true}


<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->
<!-- code_chunk_output -->

* [前言](#前言)
* [安装server](#安装server)
	* [安装系统](#安装系统)
	* [安装仓库配置包](#安装仓库配置包)
	* [server安装](#server安装)
	* [安装数据库](#安装数据库)
	* [selinux配置](#selinux配置)
	* [处理报错](#处理报错)
	* [启动zabbix](#启动zabbix)
	* [zabbix前端参数配置](#zabbix前端参数配置)
	* [启动http服务](#启动http服务)
	* [允许http端口访问](#允许http端口访问)
	* [用网页访问zabbix](#用网页访问zabbix)
* [安装zabbix-server前端](#安装zabbix-server前端)
* [安装zabbix-agent](#安装zabbix-agent)
	* [安装仓库配置包](#安装仓库配置包-1)
	* [安装软件](#安装软件)
	* [启动](#启动)

<!-- /code_chunk_output -->


## 前言

zabbix安装有很多方法，如源码安装、包安装、容器安装，本文介绍centos 7下的包安装方法；如读者需要了解其他安装方法请阅读：https://www.zabbix.com/documentation/3.4/manual/installation。  
zabbix安装包括两个部分，zabbix-server安装,zabbix-agent安装；


## 安装server

### 安装系统

下载最小版centos 7,安装系统，本文不详细介绍系统安装

### 安装仓库配置包

```
# rpm -ivh http://repo.zabbix.com/zabbix/3.4/rhel/7/x86_64/zabbix-release-3.4-1.el7.centos.noarch.rpm
```

### server安装

```
# yum install zabbix-server-mysql zabbix-web-mysql
```

### 安装数据库

* 安装数据库方法请查看 [MYSQL安装](/mysql/install.md)

* 生成数据库
```
shell> mysql -uroot -p<password>
mysql> create database zabbix character set utf8 collate utf8_bin;
mysql> grant all privileges on zabbix.* to zabbix@localhost identified by '<password>';
mysql> quit;
```

* 导入初始化数据库
```
# zcat /usr/share/doc/zabbix-server-mysql-3.4.1/create.sql.gz | mysql -uzabbix -p zabbix
```
上诉脚本会需要我们输入密码才能够正常执行，并且请注意上面命令的版本``3.4.1``有可能不同，如果提示找不到文件，可以查看一下具体版本号，重新执行该命令； 

* 检查server是否正常安装
```
# rpm -q zabbix-server-mysql
```
* 配置数据库
根据实际情况，配置数据库
```
# vi /etc/zabbix/zabbix_server.conf
DBHost=localhost
DBName=zabbix
DBUser=zabbix
DBPassword=<password>
```
注： 上面几个配置并不连续，读者可以自行搜索几个配置项所在位置；

### selinux配置

需要设置selinux,方法如下(推荐方法2)：
1. 关闭selinux（不推荐）
```
setenforce 0
```
2. 更新selinux策略
```
yum update selinux-policy.noarch selinux-policy-targeted.noarch
```
//todo 这个是否有必要执行
//Having SELinux status enabled in enforcing mode, you need to execute the following command to enable successful connection of Zabbix frontend to the server:
```
# setsebool -P httpd_can_connect_zabbix on
```

今天发现centos 7 1611使用此方法并不管用，现新增方法如下：

1.安装selinux相关工具

yum install policycoreutils-python
2.如果是server_agent端，则按照以下操作进行

```
cat /var/log/audit/audit.log | grep zabbix_agentd | grep denied | audit2allow -M zabbix_agent_setrlimit
```
执行上述命令后，会在当前目录生成一个名为zabbix_agent_setrlimit.pp的文件，接下来执行以下命令

```
semodule -i zabbix_agent_setrlimit.pp
```
如果是server端，则按照如下方法执行即可
```
cat /var/log/audit/audit.log | grep zabbix_server | grep denied | audit2allow -M zabbix_server_setrlimit
semodule -i zabbix_server_setrlimit.pp
```

### 处理报错
```
zabbix_agentd [20529]: cannot create Semaphore: [28] No space left on device
zabbix_agentd [20529]: unable to create mutex for log file
```
为避免如上报错，可修改文件``/etc/sysctl.conf``,添加如下行。  
```
kernel.sem = 500        64000   64      256
```
执行``sysctl -p``使其生效。

### 启动zabbix 
```
# systemctl start zabbix-server
# systemctl enable zabbix-server
```

### zabbix前端参数配置

``/etc/httpd/conf.d/zabbix.conf``文件，读者可以自行修改；
```
php_value max_execution_time 300
php_value memory_limit 128M
php_value post_max_size 16M
php_value upload_max_filesize 2M
php_value max_input_time 300
php_value always_populate_raw_post_data -1
php_value date.timezone Asia/Chongqing
```
注意：默认的timezone需要根据实际情况设置

### 启动http服务

```
# systemctl start httpd
# systemctl enable httpd
```

### 允许http端口访问

打开端口
```
firewall-cmd --zone=public --add-port=80/tcp --permanent
```
* zone #作用域
* add-port=80/tcp  #添加端口，格式为：端口/通讯协议
* permanent  #永久生效，没有此参数重启后失效

重启防火墙
```
firewall-cmd --reload
```

### 用网页访问zabbix
在浏览器中输入地址``http://{ip_address}/zabbix``,访问zabbix主页，如果能打开则安装成功。

![](assets/2017-09-08-12-24-16.png)


## 安装zabbix-server前端

* 打开网站``http://{ip_address}/zabbix``
![](assets/2017-09-08-17-00-05.png)

* 检查网站安装需求；（如果有失败，可修改``/etc/httpd/conf.d/zabbix.conf``）
![](assets/2017-09-08-17-05-58.png)

* 配置数据库
![](assets/2017-09-08-17-10-29.png)

* 配置监听端口、域名、服务器名字
![](assets/2017-09-08-17-11-27.png)

* 检查配置汇总
![](assets/2017-09-08-17-11-54.png)

* 安装完成
![](assets/2017-09-08-17-12-26.png)
后续如果需要修改配置，可以到``/etc/zabbix/web/zabbix.conf.php``上修改。

* 登录系统
![](assets/2017-09-08-17-15-08.png)

默认用户：Admin
默认密码：zabbix



## 安装zabbix-agent

安装zabbix-agent安装在被安装电脑上
### 安装仓库配置包

```
# rpm -ivh http://repo.zabbix.com/zabbix/3.4/rhel/7/x86_64/zabbix-release-3.4-1.el7.centos.noarch.rpm
```

### 安装软件
```
# yum install zabbix-agent
```
### 启动
```
service zabbix-agent start
chkconfig --add zabbix-agent
```

说明： 
chkconfig 功能说明：检查，设置系统的各种服务。
语法：chkconfig [--add][--del][--list][系统服务] 或 chkconfig [--level <等级代号>][系统服务][on/off/reset]
--add 添加服务
--del 删除服务
--list 查看各服务启动状态