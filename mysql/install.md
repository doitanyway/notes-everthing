# 安装 {ignore=true}


<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->
<!-- code_chunk_output -->

* [centos 6](#centos-6)
	* [下载安装包](#下载安装包)
	* [安装](#安装-1)
	* [安装完的配置](#安装完的配置)
* [centos 7](#centos-7)
	* [安装rpm包](#安装rpm包)
	* [yum安装](#yum安装)
	* [安装完的配置](#安装完的配置-1)

<!-- /code_chunk_output -->


## centos 6

### 下载安装包

* 下载
```
[linux]# wget https://dev.mysql.com/get/Downloads/MySQL-5.6/MySQL-5.6.38-1.el6.x86_64.rpm-bundle.tar
[linux]# tar -xvf MySQL-5.6.38-1.el6.x86_64.rpm-bundle.tar
[linux]# wget http://mirror.centos.org/centos/6/os/i386/Packages/libaio-0.3.107-10.el6.i686.rpm
```
这里注意:el6是针对centos6版本，7是真的centos7版本

* 删除旧包
```
[linux]# rpm -e --nodeps mysql-libs-5.1.*
```

### 安装

* 按照依赖包
```
rpm -ivh libaio-0.3.107-10.el6.i686.rpm
```

* 安装clint和server

```
[linux]# rpm -ivh MySQL-client-5.6.38-1.el6.x86_64.rpm 
[linux]# rpm -ivh MySQL-server-5.6.38-1.el6.x86_64.rpm 

```

### 安装完的配置


* 启动mysql服务进程
```
[linux]# service start mysql
```

* 重置密码
```
[linux]# mysql_secure_installation
```

* 设置远程登陆

```
[linux]# mysql -uroot -p111111

mysql> set password=password('111111');
Query OK, 0 rows affected (0.00 sec)

mysql> grant all privileges on *.* to root@"%" identified by "111111";
Query OK, 0 rows affected (0.00 sec)

mysql>  flush privileges;
Query OK, 0 rows affected (0.00 sec)

mysql> use mysql;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> update db set host = '%' where user = 'root'; 
Query OK, 0 rows affected (0.00 sec)
Rows matched: 0  Changed: 0  Warnings: 0

mysql> flush privileges;
Query OK, 0 rows affected (0.00 sec)

mysql> exit;
Bye
```

* 修改mysql的字符集``vi /usr/my.cnf``，文件末尾添加
```
character-set-server=utf8
lower_case_table_names=1
max_connections=1000
```

* 重启mysql,``service mysql restart``

* 检查字符集是否生效
```
[linux]# mysql -uroot -p111111

mysql> show variables like 'character%';
+--------------------------+----------------------------+
| Variable_name            | Value                      |
+--------------------------+----------------------------+
| character_set_client     | utf8                       |
| character_set_connection | utf8                       |
| character_set_database   | utf8                       |
| character_set_filesystem | binary                     |
| character_set_results    | utf8                       |
| character_set_server     | utf8                       |
| character_set_system     | utf8                       |
| character_sets_dir       | /usr/share/mysql/charsets/ |
+--------------------------+----------------------------+
8 rows in set (0.00 sec)
```

## centos 7

### 安装rpm包

安装带有可用的mysql5系列社区版资源的rpm包

```
# rpm -Uvh http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
获取http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
准备中...                          ################################# [100%]
正在升级/安装...
   1:mysql-community-release-el7-5    ################################# [100%]
```

这个时候查看当前可用的mysql安装资源：
```
# yum repolist enabled | grep "mysql.*-community.*"
mysql-connectors-community/x86_64 MySQL Connectors Community                  17
mysql-tools-community/x86_64      MySQL Tools Community                       31
mysql56-community/x86_64          MySQL 5.6 Community Server                 199
```

### yum安装

```
# yum -y install mysql-community-server
...
```

### 安装完的配置

* 加入开机启动
```
# systemctl enable mysqld
```

* 启动mysql服务进程
```
# systemctl start mysqld
```

* 重置密码
```
# mysql_secure_installation
```
