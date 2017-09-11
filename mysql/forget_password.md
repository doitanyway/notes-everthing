# MYSQL 忘记密码 {ignore=true}


<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->
<!-- code_chunk_output -->

* [使用条件](#使用条件)
* [修改mysql登录设置](#修改mysql登录设置)
* [重启登陆mysql](#重启登陆mysql)
* [修改密码](#修改密码)
* [还原mysql登陆设置重启](#还原mysql登陆设置重启)

<!-- /code_chunk_output -->

## 使用条件

本文介绍在CENTOS 6下面，如果忘记MYSQL ROOT密码，如何恢复。
* centos 6；
* 安装好vim编辑器，如果未安装则运行``yum install vim``安装；

## 修改mysql登录设置

打开文件``vim /etc/my.cnf``添加``skip-grant-tables``

```
[mysqld] 
datadir=/var/lib/mysql 
socket=/var/lib/mysql/mysql.sock 
skip-grant-tables 
```

## 重启登陆mysql

重启，使用空密码登陆mysql。

```
service mysqld restart 
mysql
```

## 修改密码

修改密码，保存退出  

```
mysql> USE mysql ; 
Database changed 
mysql> UPDATE user SET Password = password ( 'new-password' ) WHERE User = 'root' ; 
Query OK, 0 rows affected (0.00 sec) 
Rows matched: 2 Changed: 0 Warnings: 0 
mysql> flush privileges ; 
Query OK, 0 rows affected (0.01 sec) 
mysql> quit
```

## 还原mysql登陆设置重启

``vim /etc/my.cnf ``  

```
[mysqld] 
datadir=/var/lib/mysql 
socket=/var/lib/mysql/mysql.sock 
#skip-grant-tables 
```
重启mysql服务
```
service mysqld restart 
```