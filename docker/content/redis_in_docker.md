# 构建redis镜像的dockerfile详解
## 1 构建redis镜像的dockerfile编写
```
FROM centos
#WORKDIR /usr/local/rediscluster

ADD redis-2.8.16.tar.gz /usr/local/rediscluster
ADD redis.conf /usr/local/rediscluster
ADD redis2.conf /usr/local/rediscluster
ADD redis3.conf /usr/local/rediscluster
ADD sentinel.conf /usr/local/rediscluster
ADD redis.sh /usr/local/rediscluster
ENV REDISPATH /usr/local/rediscluster
WORKDIR $REDISPATH
RUN \
    mkdir /var/redis/data &&\
   # cd /usr/local/rediscluster&&\
   # wget http://download.redis.io/redis-stable.tar.gz && \
    chmod +x /usr/local/rediscluster/redis.sh
    cd /usr/local/rediscluster/redis-2.8.16 &&\
    yum -y install gcc automake autoconf libtool make &&\
    make &&\
    make install

#http://download.redis.io/releases/redis-2.8.16.tar.gz
#RUN tar xvf -C redis-2.8.16.tar.gz
#-C /usr/local/ && mv /usr/local/redis-2.8.16/ /usr/local/redis
#RUN wget http://code.taobao.org/svn/openclouddb/downloads/old/MyCat-Sever-1.2/Mycat-server-1.2-GA-linux.tar.gz
#COPY redis.sh /usr/local/redis.sh

EXPOSE 6379 6479 6579 26379
#ENTRYPOINT ["redis.sh"]
#ENTRYPOINT ["redis-server", "/etc/redis/sentinel.conf", "--sentinel"]
#CMD /bin/sh
CMD ["sh","redis.sh"]
```
## 2 redis.sh
  ```
#!/bin/sh
exec /usr/local/bin/redis-server /usr/local/rediscluster/redis.conf &
exec /usr/local/bin/redis-server /usr/local/rediscluster/redis2.conf &
exec /usr/local/bin/redis-server /usr/local/rediscluster/redis3.conf &
exec /usr/local/bin/redis-server /usr/local/rediscluster/sentinel.conf --sentinel
  ```
## 3 建立镜像
```
docker build -it redis2.8:v1 .
```
## 4 启动容器
```
docker run --name redis_v1 -it [redis镜像id]

```
## 进入容器内部，启动redis.sh脚本。一般来说，不应在进入容器内部操作，但应个人能力有限，暂时未找到其它的解决方案。
```
- docker exec -ti 容器ID /bin/bash
- cd /usr/local/rediscluster
- ./redis.sh

```
## 注意事项
docker搭建redis注意事项[https://segmentfault.com/a/1190000004478606]

#redis哨兵搭建方式二
 ## sentinel实例的dockerfile
 ```
 #基础镜像使用官方redis:3.2
 FROM redis:3.2
 
 #对外暴露26379接口
 EXPOSE 26379
 #替换原有的sentinel.conf文件
 ADD sentinel.conf /etc/redis/sentinel.conf
 RUN chown redis:redis /etc/redis/sentinel.conf
 #定义环境变量
 ENV SENTINEL_QUORUM 2
 ENV SENTINEL_DOWN_AFTER 30000
 ENV SENTINEL_FAILOVER 180000
 #把容器启动时要执行的脚本复制到镜像中
 COPY sentinel-entrypoint.sh /usr/local/bin/
 #给脚本添加可执行权限
 RUN chmod +x /usr/local/bin/sentinel-entrypoint.sh
 #定义启动容器时自动执行的脚本
 ENTRYPOINT ["sentinel-entrypoint.sh"]

```
## sentinel-entrypoint.sh
```
#!/bin/sh
#替换原有的配置参数
sed -i "s/\$SENTINEL_QUORUM/$SENTINEL_QUORUM/g" /etc/redis/sentinel.conf
sed -i "s/\$SENTINEL_DOWN_AFTER/$SENTINEL_DOWN_AFTER/g" /etc/redis/sentinel.conf
sed -i "s/\$SENTINEL_FAILOVER/$SENTINEL_FAILOVER/g" /etc/redis/sentinel.conf
#再执行另一个脚本
exec docker-entrypoint.sh redis-server /etc/redis/sentinel.conf --sentinel

```
## sentinel.conf
```
#Example sentinel.conf can be downloaded from http://download.redis.io/redis-stable/sentinel.conf

port 26379

dir /tmp
#redis-master就是master的ip别名，定义在docker-compose.yml中
sentinel monitor mymaster redis-master 6379 $SENTINEL_QUORUM

sentinel down-after-milliseconds mymaster $SENTINEL_DOWN_AFTER

sentinel parallel-syncs mymaster 1

sentinel failover-timeout mymaster $SENTINEL_FAILOVER
```

##docker-compose.yml
  - 在这里我构建了1个master,1个slave,分别使用6379和6479映射出去
  - sentinel实例监控master和slave
  - environment定义全局变量，可以sentinel-entrypoint.sh使用
 
```
master:
  image: redis:3.2
  ports:
    - "6379:6379"
slave:
  image: redis:3.2
  command: redis-server --slaveof redis-master 6379
  ports:
    - "6479:6379"
  links:
    - master:redis-master
sentinel:
  image: redis_sentinel:0.1
  environment:
    - SENTINEL_DOWN_AFTER=5000
    - SENTINEL_FAILOVER=5000
  links:
    - master:redis-master
    - slave
  ports:
    - "26379:26379"
```
## 构建sentinel镜像
```
docker build -t redis_sentinel:0.1 .
```
## 启动docker-compose.yml中定义的多个容器（master+slave+sentinel）
```
docker-compose up
```