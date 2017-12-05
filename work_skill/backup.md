# 备份系统 {ignore=true}


<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->
<!-- code_chunk_output -->

* [简介](#简介)
* [备份步骤-mysqldump](#备份步骤-mysqldump)
	* [关闭服务](#关闭服务)
	* [建立备份目录](#建立备份目录)
	* [备份数据库](#备份数据库)
	* [备份工程文件](#备份工程文件)
	* [总结](#总结)
* [克隆](#克隆)
* [备份步骤-xtrabackup](#备份步骤-xtrabackup)
* [安装软件](#安装软件)
* [完全备份](#完全备份)

<!-- /code_chunk_output -->

## 简介

在工作中，我们经常会遇到需要备份系统，在这种条件下，我们应该怎么样手动备份更为高效呢？本文提供了一种手动备份的方法供参考。

## 备份步骤-mysqldump

### 关闭服务

```
ps -ef | grep tomcat 
kill xxx 
```
如上所示，先查找tomcat进程，结束相关进程；


### 建立备份目录

本文以``/home/urpcs_backup_20170913``为例。

```
mkdir -p /home/urpcs_backup_20170913
```

注：-p表示如果父目录不存在则直接创建;

### 备份数据库 

```
mysqldump -R -E -uroot -pXXXXX --default-character-set=utf8 db_name >/home/urpcs_backup_20170913/db_name.sql
```
注意：如果不是本级，则需要调用命令 -h10.154.0.43 -P3341 

### 备份工程文件

```
tar -czf /home/urpcs_backup_20170913/URPCSF0008.0_20170913.tar.gz  URPCSF0008.0
```

备份工程文件；


### 总结

完成备份之后，我们存在了两个文件，分别是：   
/home/urpcs_backup_20170913/URPCSF0008.0_20170913.tar.gz  
/home/urpcs_backup_20170913/db_name.sql

## 克隆

假设已经存在的数据库名字叫db，想要复制一份，命名为newdb。步骤如下：

1. 首先创建新的数据库urpcs

```
# mysql -u root -ppassword
mysql>CREATE DATABASE `newdb` DEFAULT CHARACTER SET UTF8 COLLATE UTF8_GENERAL_CI;
```

2. 使用mysqldump及mysql的命令组合，一次性完成复制

```
# mysqldump db1 -u root -ppassword --add-drop-table | mysql newdb -u root -ppassword
```
（注意-ppassword参数的写法：-p后面直接跟密码，中间没有空格)


```
mysql -u root -pfangle@FANGLE

CREATE DATABASE `urpcs20171026` DEFAULT CHARACTER SET UTF8 COLLATE UTF8_GENERAL_CI;

mysqldump -R -E -uroot -pfangle@FANGLE --default-character-set=utf8 urpcs | mysql urpcs20171026 -u root -pfangle@FANGLE
```
要忽略指定表格备份：
```
mysqldump -R -E -uroot -pfangle@FANGLE --ignore-table=urpcs.urpcs_artificialrecord --default-character-set=utf8 urpcs | mysql urpcs20171026 -u root -pfangle@FANGLE
```

以上是在同一台MySQL服务器上复制数据库的方法。如果要复制到远程另一台MySQL服务器上，可以使用mysql的“ -h 主机名/ip”参数。前提是mysql允许远程连接，且远程复制的传输效率和时间可以接受。

```
# mysqldump db1 -uroot -ppassword --add-drop-table | mysql -h 192.168.1.22 newdb -uroo
```


## 备份步骤-xtrabackup

## 安装软件

* 安装``rsync``,执行命令``yum install rsync``
* 依赖安装，``yum -y install perl perl-devel libaio libaio-devel perl-Time-HiRes perl-DBD-MySQL``
* 安装``libev-4``
	* 下载： ``wget http://dl.fedoraproject.org/pub/epel/6/x86_64//libev-4.03-3.el6.x86_64.rpm``
	* 安装：``rpm -ivh libev-4.03-3.el6.x86_64.rpm``
	注意：如果需要离线安装，请提前下载；
* 安装xtrabackup
	* 下载：``wget https://www.percona.com/downloads/XtraBackup/Percona-XtraBackup-2.4.8/binary/redhat/6/x86_64/percona-xtrabackup-24-2.4.8-1.el6.x86_64.rpm``,更多版本请查看[官网](https://www.percona.com/downloads/XtraBackup/LATEST/binary/)
	* 安装：``rpm -ivh percona-xtrabackup-24-2.4.8-1.el6.x86_64.rpm``

## 完全备份

* 完全备份
```
innobackupex --defaults-file=/etc/my.cnf --user=root --password=123456 --socket=/tmp/mysql.sock  /home/backup
```

* 完全恢复



