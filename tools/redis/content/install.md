# redis安装

## 目的  
本文将指导如何再cent os 上安装redis软件.  
本文centos使用容器技术实验，``docker run --name redis1 -p 6379:6379  -d -i -t centos /bin/bash``，同时也可以使用虚拟机完成。

# 操作步骤

* 安装vim、wget,``yum install -y vim wget``  (如果已经安装则不需要继续安装)
* 安装gcc ``yum -y install gcc automake autoconf libtool make``
* 下载redis    
```
cd /usr/local
wget http://download.redis.io/releases/redis-4.0.9.tar.gz
```
* 安装redis
```
tar -xzvf redis-4.0.9.tar.gz 
cd redis-4.0.9
make
make PREFIX=/usr/local/redis/redis install
```

* 启动redis服务
```
cd /usr/local/redis/redis/bin       
./redis-server 
```

* 新建一个控制台窗口，启动客户端，测试
```
cd /usr/local/redis/redis/bin/
./redis-cli 
127.0.0.1:6379> set name nick
OK
127.0.0.1:6379> get name 
"nick"
127.0.0.1:6379> 
```

* 设置redis服务自启动
    * 进入刚才服务器启动窗口，按``ctl+c``
    * ``cd /usr/local/redis-4.0.9``
    * ``cp redis.conf /usr/local/redis/redis/bin``
    * ``cd /usr/local/redis/redis/bin``
    * ``vim redis.conf``,修改``daemonize no``为``daemonize yes``
    * 启动redis,``./redis-server redis.conf``



## 关闭redis

* 杀死进程
```
[root@bcc2e7849402 bin]# ps -ef | grep redis
root      3463     0  0 01:52 ?        00:00:00 ./redis-server 127.0.0.1:6379
root      3470    15  0 01:54 pts/1    00:00:00 grep --color=auto redis
[root@bcc2e7849402 bin]# kill 3463
[root@bcc2e7849402 bin]# ps -ef | grep redis
root      3472    15  0 01:59 pts/1    00:00:00 grep --color=auto redis
[root@bcc2e7849402 bin]# 
```

* shutdown

```
[root@bcc2e7849402 bin]# ./redis-cli shutdown
[root@bcc2e7849402 bin]# ps -ef | grep redis
```


* 开启远程端口

```
/sbin/iptables -I INPUT -p tcp -dport 6379 -j ACCEPT
/etc/rc.d/init.d/iptables save
```

