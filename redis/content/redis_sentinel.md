# redis高可用sentinel安装

## 前言

本文介绍redis高可用哨兵模式的部署方法。 在开始本文之前，服务器需要已经安装好redis软件。 如果还未安装好，则请参考[redis安装](./install.md)


本文部署软件架构如下：

![](./assets/2018-06-17-15-59-59.png)


* 1主，2从，3哨兵的模式。 
* 压实部署的时候都部署在一台电脑上，在生产服务器上，需要分开部署才能保证高可用性；

## 部署

### 配置开启主从节点；

* 创建文件夹``mkdir -p  /opt/soft/redis/data`` ``mkdir -p /var/log/redis/``
* 在redis安装包下面找到redis.conf文件，复制出三个文件，作为主从节点的配置文件``6379.conf``,``6380.conf``,``6381.conf``；

* 修改配置文件``6379.conf``
    ```
    port 6379
    daemonize yes
    pidfile /var/run/redis-6379.pid
    logfile "/var/log/redis/6379.log"
    dir /opt/soft/redis/data/
    ```

* 修改配置文件``6380.conf``
    ```
    port 6380
    daemonize yes
    pidfile /var/run/redis-6380.pid
    logfile "/var/log/redis/6380.log"
    dir /opt/soft/redis/data/
    slaveof 192.168.3.52 6380
    ```

* 修改配置文件``6381.conf``
    ```
    port 6381
    daemonize yes
    pidfile /var/run/redis-6381.pid
    logfile "/var/log/redis/6381.log"
    dir /opt/soft/redis/data/
    slaveof 192.168.3.52 7000
    ```

* 启动三个节点    
    ````
    redis-server 6379.conf
    redis-server 6380.conf
    redis-server 6381.conf
    ````

* 验证主从节点是否安装好   
    ```shell
    [root@bogon conf]# redis-cli -p 6379 info replication
    # Replication
    role:master
    connected_slaves:2
    slave0:ip=192.168.3.52,port=6380,state=online,offset=98,lag=0
    slave1:ip=192.168.3.52,port=6381,state=online,offset=98,lag=0
    master_replid:b891df80a8b879c7ca8385b91721d3df0da76b25
    master_replid2:0000000000000000000000000000000000000000
    master_repl_offset:98
    second_repl_offset:-1
    repl_backlog_active:1
    repl_backlog_size:1048576
    repl_backlog_first_byte_offset:1
    repl_backlog_histlen:98
    ```

### 配置开启sentinel控制节点（sentinel是特殊的redis）

* 在redis安装包下面找到sentinel.conf文件，复制出文件``26379.conf``  
* 修改文件``vim 26379.conf``    
    ```
    port 26379
    protected-mode no
    daemonize yes
    dir /opt/soft/redis/data
    logfile "/var/log/redis/26379.log"
    sentinel monitor mymaster 192.168.3.52 6379 2
    sentinel down-after-milliseconds mymaster 30000
    sentinel parallel-syncs mymaster 1
    sentinel failover-timeout mymaster 180000
    ```

* 新建另外2个哨兵配置文件
    ```
    sed "s/26379/26380/g" 26379.conf > redis-sentinel-26380.conf
    sed "s/26379/26381/g" 26379.conf > redis-sentinel-26381.conf
    ```

* 删除2个新的配置文件，以下一行``sentinel myid 32bdc836a3f3b4a45b0e6ee0e7b209648109ec32``
    ```
    sed -i '/^sentinel myid.*/d' redis-sentinel-26380.conf
    sed -i '/^sentinel myid.*/d' redis-sentinel-26381.conf
    ```

* 启动哨兵节点
    ```
    redis-sentinel redis-sentinel-26379.conf
    redis-sentinel redis-sentinel-26381.conf 
    redis-sentinel redis-sentinel-26381.conf 
    ```

* 验证哨兵节点是否安装好，如下最后一句可以看到:有2个从节点，3个sentinels，安装完成
    ```
    [root@bogon conf]# redis-cli -p 26381 ping
    PONG
    [root@bogon conf]# redis-cli -p 26381 info sentinel
    # Sentinel
    sentinel_masters:1
    sentinel_tilt:0
    sentinel_running_scripts:0
    sentinel_scripts_queue_length:0
    sentinel_simulate_failure_flags:0
    master0:name=mymaster,status=ok,address=192.168.3.52:6379,slaves=2,sentinels=3
    ```

* 如果redis需要除了本机以外的其他端口访问，则需要打开相应端口（6379,6380,6381,26379,26380,26381），打开对应端口访问方法请参考[linux防火墙](/Linux/content/iptables.md)

## 补充说明

[配置文件](../redis)