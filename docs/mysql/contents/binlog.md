# mysql binlog

## binlog 

binlog用来存储数据的数据库的写日志，通常用在数据备份和数据同步上面。

## 打开binlog 

* ``vim /etc/mysql/my.cnf``,``[mysqld]``下面添加入下一行，重启mysql

```bash 
# 服务器唯一ID
server-id=1   
# 设置日志格式 STATEMENT、ROW、MIXED 
binlog_format = mixed
log-bin=mysql-bin
#设置binlog清理时间
expire_logs_days = 7
#binlog每个日志文件大小
max_binlog_size = 100m
# binlog缓存大小
binlog_cache_size = 4m
#最大binlog缓存大小
max_binlog_cache_size = 512m
```


## 常见命令

```bash 
mysql -uroot -p 
# 查看binlog在什么地方
show global variables like '%datadir%';
# log_bin查看是否打开
show variables like '%log_bin%';
# 显示mysql bin log 文件
show master logs;
# 显示最新的一个bin log日志放在哪一个文件下面，它的位置在什么地方
show master status;

```

* 使用命令查看binlog 

```bash 
mysqlbinlog  --base64-output=DECODE-ROWS -v -d mbook mysql-bin.00003 
```



