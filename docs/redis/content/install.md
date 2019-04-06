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
# wget http://download.redis.io/releases/redis-4.0.9.tar.gz
wget http://download.redis.io/releases/redis-4.0.14.tar.gz
```
* 安装redis
```
tar -xzvf redis-*.tar.gz 
cd redis-4.0.14/
make
make PREFIX=/usr/local/ install
```

* 添加redis命令到path环境变量中,``vim ~/.bash_profile`` ,在``export PATH``下面添加如下语句，添加后执行命令生效配置``source  ~/.bash_profile``
```
PATH=$PATH:/usr/local/bin/
export PATH
```

* source ~/.bash_profile

*  redis 配置文件

```
cd /usr/local/redis-4.0.14
mkdir /etc/redis 
cp redis.conf /etc/redis/6379.conf
# 修改6379.conf 中的  ``daemonize no``为``daemonize yes``,改为后台启动模式
cp sentinel.conf /etc/redis/
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
