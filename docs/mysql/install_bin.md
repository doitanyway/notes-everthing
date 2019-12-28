#  二进制安装

* 安装辅助软件  
```BASH 
yum install -y libaio* vim wget 
```
* 下载文件[mysql-5.7.26-el7-x86_64.tar.gz]()  

*  删除原有安装文件

```bash
# NySQL
rpm -qa |grep mysql
yum remove mysql*
# MariaDB
rpm -qa |grep mariadb
yum remove mariadb*
```

* 新增用户，用户组

```bash 
groupadd mysql
useradd -d /home/mysql -g mysql -m mysql
passwd mysql
mysql

vi ~/.bash_profile

# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin:/u01/MySQL5.7/bin

export PATH

[mysql@localhost ~]$ source ~/.bash_profile
```

* 规划目录 赋权限

```bash 
mkdir -p /u01/MySQL5.7       

mkdir -p /MySQL/my3306/data
mkdir -p /MySQL/my3306/log/iblog
mkdir -p /MySQL/my3306/log/binlog
mkdir -p /MySQL/my3306/run
mkdir -p /MySQL/my3306/tmp

chown -R mysql:mysql /MySQL/my3306
chown -R mysql:mysql /u01/MySQL5.7
##chown -R 755 /MySQL/my3307

```



* 解压 
```BASH 
# 切换到安装包所在目录
tar -xzvf mysql-5.7.26-el7-x86_64.tar.gz
mv mysql-5.7.26-el7-x86_64/* /u01/MySQL5.7/
```

* 初始化数据库,如下记录root密码是``!92CCPSvu-hr``    
```BASH 
[root@localhost vagrant]# mysqld --initialize --user=mysql --basedir=/u01/MySQL5.7  --datadir=/MySQL/my3306/data  --explicit_defaults_for_timestamp
2019-12-28T14:34:06.593063Z 0 [Warning] InnoDB: New log files created, LSN=45790
2019-12-28T14:34:06.630268Z 0 [Warning] InnoDB: Creating foreign key constraint system tables.
2019-12-28T14:34:06.728877Z 0 [Warning] No existing UUID has been found, so we assume that this is the first time that this server has been started. Generating a new UUID: 1a50766b-297f-11ea-9415-5254008481d5.
2019-12-28T14:34:06.741816Z 0 [Warning] Gtid table is not ready to be used. Table 'mysql.gtid_executed' cannot be opened.
2019-12-28T14:34:06.742548Z 1 [Note] A temporary password is generated for root@localhost: !92CCPSvu-hr
```

* 修改配置文件 ``vi /MySQL/my3306/my.cnf``
```CONF
[mysqld]
#sql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES
basedir=/u01/MySQL5.7                              #介质目录
datadir=/MySQL/my3306/data                         #数据目录
port=3306                                          #端口
pid-file = /MySQL/my3306/data/mysql.pid            #进程id 
user = mysql                                       #启动用户
socket=/MySQL/my3306/run/mysql.sock                #sock文件地址
bind-address = 0.0.0.0                             #绑定ip 这里表示绑定所有ip
server-id = 1                                      #用于复制环境钟标识实例,这个在复制环境里唯一
character-set-server = utf8                        #服务端默认字符集,很重要,错误设置会出现乱码
max_connections = 1000                             #允许客户端并发连接的最大数量
max_connect_errors = 6000                          #如果客户端尝试连接的错误数量超过这个参数设置的值，则服务器不再接受新的客户端连接。
open_files_limit = 65535                           #操作系统允许MySQL服务打开的文件数量。
table_open_cache = 128                             #所有线程能打开的表的数量
max_allowed_packet = 4M                            #网络传输时单个数据包的大小。
binlog_cache_size = 1M
max_heap_table_size = 8M
tmp_table_size = 16M
read_buffer_size = 2M
read_rnd_buffer_size = 8M
sort_buffer_size = 8M
join_buffer_size = 8M
key_buffer_size = 4M
thread_cache_size = 8
query_cache_type = 1
query_cache_size = 8M
query_cache_limit = 2M
ft_min_word_len = 4
log_bin = mysql-bin
binlog_format = mixed
expire_logs_days = 30
log_error = /MySQL/my3306/data/mysql-error.log
slow_query_log = 1
long_query_time = 1
slow_query_log_file = /MySQL/my3306/data/mysql-slow.log
performance_schema = 0
explicit_defaults_for_timestamp
#lower_case_table_names = 1
skip-external-locking
default_storage_engine = InnoDB
#default-storage-engine = MyISAM
innodb_file_per_table = 1
innodb_open_files = 500
innodb_buffer_pool_size = 64M
innodb_write_io_threads = 4
innodb_read_io_threads = 4
innodb_thread_concurrency = 0
innodb_purge_threads = 1
innodb_flush_log_at_trx_commit = 2
innodb_log_buffer_size = 2M
innodb_log_file_size = 32M
innodb_log_files_in_group = 3
innodb_max_dirty_pages_pct = 90
innodb_lock_wait_timeout = 120
bulk_insert_buffer_size = 8M
myisam_sort_buffer_size = 8M
myisam_max_sort_file_size = 10G
myisam_repair_threads = 1
interactive_timeout = 28800
wait_timeout = 28800
#lower_case_table_names = 1
skip-external-locking
default_storage_engine = InnoDB
#default-storage-engine = MyISAM
innodb_file_per_table = 1
innodb_open_files = 500
innodb_buffer_pool_size = 64M
innodb_write_io_threads = 4
innodb_read_io_threads = 4
innodb_thread_concurrency = 0
innodb_purge_threads = 1
innodb_flush_log_at_trx_commit = 2
innodb_log_buffer_size = 2M
innodb_log_file_size = 32M
innodb_log_files_in_group = 3
innodb_max_dirty_pages_pct = 90
innodb_lock_wait_timeout = 120
bulk_insert_buffer_size = 8M
myisam_sort_buffer_size = 8M
myisam_max_sort_file_size = 10G
myisam_repair_threads = 1
interactive_timeout = 28800
wait_timeout = 28800

[client]
port=3306
socket=/MySQL/my3306/run/mysql.sock

[mysql]
socket=/MySQL/my3306/run/mysql.sock
```


* 拷贝my.cnf以及mysql.server文件 
```bash 
# cp /MySQL/my3306/my.cnf /etc/my.cnf
mv /MySQL/my3306/my.cnf /etc/my.cnf
cp /u01/MySQL5.7/support-files/mysql.server /etc/init.d/mysqld
```

* ``vim /etc/init.d/mysqld`` 

```bash 
# 文件开始位置添加一下两项
basedir=/u01/MySQL5.7
datadir=/MySQL/my3306/data
```


* 启动数据库  
```bash 
[mysql@localhost ~]$ service mysqld start
Starting MySQL.. SUCCESS! 
```

* 进入数据库，修改密码   

```
mysql -uroot -p'!92CCPSvu-hr'
set PASSWORD=PASSWORD('root');
flush privileges;
exit;
```


* 配置开机启动  

```bash 
[root@localhost vagrant]# chkconfig

Note: This output shows SysV services only and does not include native
      systemd services. SysV configuration data might be overridden by native
      systemd configuration.

      If you want to list systemd services use 'systemctl list-unit-files'.
      To see services enabled on particular target use
      'systemctl list-dependencies [target]'.

mysqld         	0:off	1:off	2:on	3:on	4:on	5:on	6:off
netconsole     	0:off	1:off	2:off	3:off	4:off	5:off	6:off
network        	0:off	1:off	2:on	3:on	4:on	5:on	6:off
```

