# mysql做主从备份

本文演示如何在mysql上建立主从备份。为了方便我们使用docker作为基础环境。


## 文件准备


* 创建文件夹

```
mkdir mysql
cd mysql 
```

* 创建如下文件

* docker-compose.yaml

```yaml
version: '3.1'

services:
  db0:
    image: mysql:5.7
    ports:
    - "3300:3306"
    # command: --default-authentication-plugin=mysql_native_password
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: 123456
    volumes:
     - ./my_master.cnf:/etc/mysql/my.cnf
  db1:
    image: mysql:5.7
    ports:
    - "3301:3306"
    # command: --default-authentication-plugin=mysql_native_password
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: 123456
    volumes:
     - ./my_slave.cnf:/etc/mysql/my.cnf
```

* my_master.cnf

```
# Copyright (c) 2016, Oracle and/or its affiliates. All rights reserved.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA

!includedir /etc/mysql/conf.d/
!includedir /etc/mysql/mysql.conf.d/
[mysqld]
# [必须]启用二进制日志
log-bin=mysql-bin   
# [必须]服务器唯一ID
server-id=1         

```

* my_slave.cnf

```
# Copyright (c) 2016, Oracle and/or its affiliates. All rights reserved.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA

!includedir /etc/mysql/conf.d/
!includedir /etc/mysql/mysql.conf.d/
[mysqld]
# [非必须]Slave可以不启用二进制日志，配置二进制日志可以便于Master和Slave交换角色
log-bin=mysql-bin   
# [必须]服务器唯一ID
server-id=2         

```

## 配置主服务器


* 查询进入主库

```bash
fangleMac:~ fangle$ docker ps 
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                               NAMES
aabec4d6d0c2        mysql:5.7           "docker-entrypoint.s…"   43 minutes ago      Up 43 minutes       33060/tcp, 0.0.0.0:3300->3306/tcp   mysql_db0_1
b59d7fe2d10a        mysql:5.7           "docker-entrypoint.s…"   43 minutes ago      Up 43 minutes       33060/tcp, 0.0.0.0:3301->3306/tcp   mysql_db1_1
fangleMac:~ fangle$ docker exec -it aabec4d6d0c2 bash 
root@aabec4d6d0c2:/# 
root@aabec4d6d0c2:/# mysql -uroot -p123456
mysql> GRANT REPLICATION SLAVE ON *.* to 'nick'@'%' identified by '123456';
mysql> FLUSH PRIVILEGES;
```

* 查看master 状态,记录File和Position值

```
mysql> show master status;
+------------------+----------+--------------+------------------+-------------------+
| File             | Position | Binlog_Do_DB | Binlog_Ignore_DB | Executed_Gtid_Set |
+------------------+----------+--------------+------------------+-------------------+
| mysql-bin.000003 |     1039 |              |                  |                   |
+------------------+----------+--------------+------------------+-------------------+
1 row in set (0.00 sec)
```

* 登陆slave节点

```
fangleMac:~ fangle$ docker ps 
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                               NAMES
aabec4d6d0c2        mysql:5.7           "docker-entrypoint.s…"   About an hour ago   Up About an hour    33060/tcp, 0.0.0.0:3300->3306/tcp   mysql_db0_1
b59d7fe2d10a        mysql:5.7           "docker-entrypoint.s…"   About an hour ago   Up About an hour    33060/tcp, 0.0.0.0:3301->3306/tcp   mysql_db1_1
fangleMac:~ fangle$ docker exec -it b59d7fe2d10a bash 
root@b59d7fe2d10a:/# mysql -uroot -p123456
mysql> change master to master_host='db0',master_user='nick',master_password='123456',master_log_file='mysql-bin.000003',master_log_pos=589;
mysql> start slave;

```


* 使用root账户登录MySQL核对Slave状态,注意Slave_IO_State，Slave_IO_Running，Slave_SQL_Running的状态

```
mysql> show slave status\G;
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: db0
                  Master_User: nick
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.000003
          Read_Master_Log_Pos: 1039
               Relay_Log_File: b59d7fe2d10a-relay-bin.000002
                Relay_Log_Pos: 770
        Relay_Master_Log_File: mysql-bin.000003
             Slave_IO_Running: Yes
            Slave_SQL_Running: Yes
```


## 测试

链接主库，新建数据库，表格，从库会自动刷新。


## 清理log

### 手动清理 

* 手动执行清理log 
```
mysql> flush logs;
Query OK, 0 rows affected, 64 warnings (0.16 sec
```

* 将bin.000055之前的binlog清掉:

```
mysql>purge binary logs to 'bin.000055';
```

* 将指定时间之前的binlog清掉:

```
mysql>purge binary logs before '2017-05-01 13:09:51';
```


###  设置自动清理binlog 

15天，最大1g。

```
expire_logs_days = 15
max_binlog_size = 1073741824
```

### 主从备份下如何清理log

* ``mysql  -u root -p`` 进入从服务器mysql控制台 ``show slave status\G;`` 检查从服务器正在读取哪个日志，有多个从服务器，选择时间最早的一个做为目标日志。

* 进入主服务器mysql控制台

```
show master logs;      #获得主服务器上的一系列日志
PURGE MASTER LOGS TO 'binlog.000058';   #删除binlog.0000058之前的，不包括binlog.000058
```