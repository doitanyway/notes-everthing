# 备份系统 {ignore=true}


<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->
<!-- code_chunk_output -->

* [简介](#简介)
* [备份步骤](#备份步骤)
	* [关闭服务](#关闭服务)
	* [建立备份目录](#建立备份目录)
	* [备份数据库](#备份数据库)
	* [备份工程文件](#备份工程文件)

<!-- /code_chunk_output -->

## 简介

在工作中，我们经常会遇到需要备份系统，在这种条件下，我们应该怎么样手动备份更为高效呢？本文提供了一种手动备份的方法供参考。

## 备份步骤

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
mysqldump -R -uroot -pXXXXX db_name>/home/urpcs_backup_20170913/db_name.sql
```

### 备份工程文件

```
tar -czf /home/urpcs_backup_20170913/URPCSF0008.0_20170913.tar.gz  URPCSF0008.0
```

备份工程文件；

### 总结

完成备份之后，我们存在了两个文件，分别是：   
/home/urpcs_backup_20170913/URPCSF0008.0_20170913.tar.gz  
/home/urpcs_backup_20170913/db_name.sql


