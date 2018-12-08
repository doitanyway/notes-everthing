# 还原系统

## 简要说明

紧接着备份系统，我们已经存在了连个备份文件，假设我们测试发现新系统存在一些问题，那么我们需要怎么还原原来的系统呢？  
本文假设我们已经有如下备份文件：
```
/home/urpcs_backup_20170913/URPCSF0008.0_20170913.tar.gz  
/home/urpcs_backup_20170913/db_name.sql
```
tomcat 目录为/user/local/tomcat/  
数据库名称为urpcs


## 恢复步骤

### 恢复数据库

```
shell> set global log_bin_trust_function_creators=TRUE;
shell> mysql -uroot -p<password>
mysql> drop database urpcs;
mysql> create database urpcs character set utf8 collate utf8_general_ci;
mysql> exit;
shell> cat /home/urpcs_backup_20170913/db_name.sql | mysql -uroot -p urpcs
```

最后一条命令可能执行时间较长，请耐心等待；


### 恢复工程文件

* 进入tomcat目录，``cd /user/local/tomcat/webapps/``
* 删除原有工程,``rm -rf URPCSF0008.0* ``
* 恢复原有工程文件``tar -xzvf /home/urpcs_backup_20170913/URPCSF0008.0_20170913.tar.gz /user/local/tomcat/webapps/``


### 启动工程

```
cd /user/local/tomcat/bin
./startup.sh
```

