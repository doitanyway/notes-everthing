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
