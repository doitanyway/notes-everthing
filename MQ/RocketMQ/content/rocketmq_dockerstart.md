# rocketmq使用docker搭建单机版，参考[文章](https://www.jianshu.com/p/139a52a90d61)
## 新建三个目录，分别是nameserver、broker、console，这三个目录分别对应的是rocketmq里面的nameserver，broker和控制台
![](2018-08-26-22-39-34.png)
## 在这三个目录分别建立三个Dockerfile
### nameserver
```
FROM java:8
ARG version
# Rocketmq version
ENV ROCKETMQ_VERSION 4.2.0
# Rocketmq home
ENV ROCKETMQ_HOME  /opt/rocketmq-${ROCKETMQ_VERSION}
WORKDIR  ${ROCKETMQ_HOME}
RUN mkdir -p \
        /opt/logs \
        /opt/store \
        /opt/conf
#这行代码进行了修改，基于本地的rocketmq编译包生成镜像，而不是通过网上下载。
ADD /rocketmq-all-4.2.0-bin-release.zip rocketmq.zip
RUN  unzip rocketmq.zip \
     && rm rocketmq.zip
RUN chmod +x bin/mqnamesrv
CMD cd ${ROCKETMQ_HOME}/bin && export JAVA_OPT=" -Duser.home=/opt" && sh mqnamesrv
EXPOSE 9876
VOLUME /opt/logs \
        /opt/store \
        /opt/conf

```
### broker
```
FROM java:8
# Rocketmq version
ENV ROCKETMQ_VERSION 4.2.0
# Rocketmq home
ENV ROCKETMQ_HOME  /opt/rocketmq-${ROCKETMQ_VERSION}
WORKDIR  ${ROCKETMQ_HOME}
RUN mkdir -p \
        /opt/logs \
        /opt/store
ADD rocketmq-all-4.2.0-bin-release.zip rocketmq.zip
RUN       unzip rocketmq.zip \
          && rm rocketmq.zip
RUN chmod +x bin/mqbroker
CMD cd ${ROCKETMQ_HOME}/bin && export JAVA_OPT=" -Duser.home=/opt" && sh mqbroker -n namesrv:9876
EXPOSE 10909 10911
VOLUME /opt/logs \
        /opt/store
```
### console
```
FROM java:8
VOLUME /tmp
ADD rocketmq-console-ng-1.0.0.jar app.jar
RUN sh -c 'touch /app.jar'
ENV JAVA_OPTS=""
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -jar /app.jar" ]

```
## 建立docker-compose.yml启动三个容器
```
version: '2'
services:
  namesrv:
   #image: going/rocketmq-namesrv:4.2.0
    build: ./nameserver/
    ports:
      - 9876:9876
    volumes:
      - "/home/rocketmq_docker/namesrv/logs:/opt/logs"
      - "/home/rocketmq_docker/namesrv/store:/opt/store"
  broker:
   #image: going/rocketmq-broker:4.2.0
    build: ./broker/
    ports:
      - 10909:10909
      - 10911:10911
    volumes:
      - "/home/rocketmq_docker/broker/logs:/opt/logs"
      - "/home/rocketmq_docker/broker/store:/opt/store"
    links:
      - namesrv:namesrv
  console:
   #image: styletang/rocketmq-console-ng:latest
    build: ./console/
    ports:
     - "8080:8080"
    links:
     - namesrv:namesrv
    environment:
     JAVA_OPTS: -Drocketmq.config.namesrvAddr=namesrv:9876 -Dcom.rocketmq.sendMessageWithVIPChannel=false
  #producer:
   #image: going/rocketmq-producer:4.1.0
   #links:
    #- namesrv:namesrv
  #consumer:
   #image: going/rocketmq-consumer:4.1.0
   #links:
    #- namesrv:namesrv

```
## 启动容器，查看监控页面(http://ip:8080/#/)
```
docker-compose up --build -d
```
