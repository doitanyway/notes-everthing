# 常用docker容器


* centos 

```bash 
docker run -d centos tail -f /dev/null
```

* mysql 

```bash
docker run --name some-mysql  \
   -v $PWD/datadir:/var/lib/mysql \
    -e MYSQL_ROOT_PASSWORD=123456 -p 3307:3306 -d mysql:5.7
```

* emq 

```bash 
docker run -d --name emqx -p 18083:18083 -p 1883:1883 emqx/emqx:v4.0.1  
```


* Nexus3 

```BASH
# 挂载目录运行
docker run -d \
    -p 8081:8081 -p 8082:8082 -p 8083:8083 -p 8084:8084 \
    -v /opt/nexus-data:/nexus-data --name nexus3 sonatype/nexus3 
# 不挂载目录运行，测试
docker run -d \
    -p 8081:8081 -p 8082:8082 -p 8083:8083 -p 8084:8084 \
     --name nexus3 sonatype/nexus3 
```