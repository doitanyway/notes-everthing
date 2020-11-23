# redis安装

## 目的  
本文将指导如何再cent os 上安装redis软件.  
本文centos使用容器技术实验，``docker run --name redis1 -p 6379:6379  -d -i -t centos /bin/bash``，同时也可以使用虚拟机完成。

## 安装redis哨兵脚本

```bash

cat << EOF > redis_param.sh
export redis_nodes=(node1 node2 node3)
export redis_slave_nodes=(node2 node3)
export redis_master=node1
EOF

source redis_param.sh  
 
# 如果文件不存在则下载
# wget https://download.redis.io/releases/redis-5.0.5.tar.gz


# 编译
for node in ${redis_nodes[@]}; do 
  echo "$node ......sync files";
  scp -r redis-*.tar.gz root@$node:~/
  ssh root@$node   "tar -xzvf redis-*.tar.gz "
  ssh root@$node   "mv redis-5.*/ redis"
  ssh root@$node   "cd redis && make && cd src && make PREFIX=/usr/local/ install"
  ssh root@$node   "sed -i '/REDIS_PATH/d' /etc/profile"
  ssh root@$node   "echo 'export PATH=\$PATH:/usr/local/bin    # REDIS_PATH ' >> /etc/profile"
  ssh root@$node   "mkdir -p /etc/redis && mkdir -p /data/redis/sentinel"
done 


# /etc/redis/redis6379.conf  
cat << EOF > redis6379_master.conf
port 6379
daemonize yes
bind 0.0.0.0
requirepass "crcloud!"
dir "/data/redis/redis6379"
logfile "/data/redis/redis6379/6379.log"
pidfile "/var/run/redis_6379.pid"

maxmemory 1000000kb
min-replicas-to-write 1
min-replicas-max-lag 10
masterauth "crcloud!"
appendonly yes
# replicaof node1 6379
EOF


cat << EOF > redis6379_slave.conf
port 6379
daemonize yes
bind 0.0.0.0
requirepass "crcloud!"
dir "/data/redis/redis6379"
logfile "/data/redis/redis6379/6379.log"
pidfile "/var/run/redis_6379.pid"

maxmemory 1000000kb
min-replicas-to-write 1
min-replicas-max-lag 10
masterauth "crcloud!"
appendonly yes
replicaof $redis_master 6379
EOF


# /etc/redis/sentinel.conf   
cat << EOF > sentinel.conf
port 26379
daemonize yes
dir "/data/redis/sentinel"
logfile "/data/redis/sentinel/sentinel.log"
sentinel myid 9a7d8b883a6e37d9acb8538b12bdf5d8dcdfc089
sentinel deny-scripts-reconfig yes
sentinel monitor crc-redis-sentinel $redis_master 6379 2
sentinel down-after-milliseconds crc-redis-sentinel 5000
sentinel failover-timeout crc-redis-sentinel 60000
EOF

# 先清理数据  
for node in ${redis_nodes[@]}; do 
  echo "$node ......config files";
  ssh root@$node   "rm -rf /etc/redis && rm -rf /data/redis"
  ssh root@$node   "mkdir -p /etc/redis && mkdir -p /data/redis/sentinel && mkdir -p /data/redis/redis6379"  
done 

# master配置文件  
scp -r sentinel.conf root@$redis_master:/etc/redis/sentinel.conf
scp -r redis6379_master.conf root@$redis_master:/etc/redis/redis6379.conf

# slave配置文件  
for node in ${redis_slave_nodes[@]}; do 
  echo "$node ......slave config files";
  scp -r sentinel.conf root@$node:/etc/redis/sentinel.conf
  scp -r redis6379_slave.conf root@$node:/etc/redis/redis6379.conf
done 


# 修改文件所有权
for node in ${redis_nodes[@]}; do 
  echo "$node ......set the owner of redis";
  ssh root@$node   "chown -R appuser:appuser /etc/redis/"
  ssh root@$node   "chown -R appuser:appuser /data/redis/"
done 


# 启动
for node in ${redis_nodes[@]}; do 
  echo "$node ......set the owner of redis";
  ssh root@$node   "sudo -u appuser -s /bin/bash -c '/usr/local/bin/redis-server /etc/redis/redis6379.conf'"
  ssh root@$node   "sudo -u appuser -s /bin/bash -c '/usr/local/bin/redis-sentinel /etc/redis/sentinel.conf'"
done 

```

## 启动

```bash 

for node in ${redis_nodes[@]}; do 
  echo "$node ......start up all redis";
  ssh root@$node   "sudo -u appuser -s /bin/bash -c '/usr/local/bin/redis-server /etc/redis/redis6379.conf'"
  ssh root@$node   "sudo -u appuser -s /bin/bash -c '/usr/local/bin/redis-sentinel /etc/redis/sentinel.conf'"
done 


```

## 检查状态

```bash 

for node in ${redis_nodes[@]}; do 
  echo "$node ......kill all redis";
  ssh root@$node   "ps -ef | grep bin/redis- "
done 

```

## 关闭


```bash 

for node in ${redis_nodes[@]}; do 
  echo "$node ......kill all redis";
  ssh root@$node   "ps -ef | grep bin/redis- | grep -v grep | awk '{print \$2}' | xargs -r kill -9"
done 

```






## 开机开机启动

```
cp utils/redis_init_script /etc/init.d/redis
chmod +x /etc/init.d/redis 
chkconfig redis on 
service redis start
```

* 启动客户端，测试redis 是否正常启动。   
```
redis-cli 
127.0.0.1:6379> set name nick
OK
127.0.0.1:6379> get name 
"nick"
127.0.0.1:6379> 
```


## 开启远程端口

* 详细见[linux防火墙](/docs/Linux/content/iptables.md)
