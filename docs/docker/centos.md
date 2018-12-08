# centos


## 手动启动docker

* 启动docker 

```
[linux]$ docker run -d centos tail -f /dev/null
```

* 到容器内执行命命令

```
[linux]$ docker exec -it container_name bash
```

* 安装java 

```
$ yum install java 
$ java -version
```


## 从docker执行springboot

* 新建文件夹tmp
* 拷贝spring boot jar报到该目录下；spring-boot-web-0.0.1-SNAPSHOT.jar
* ``vim Dockerfile``新建文件，编辑内容如下：

```
FROM centos
  
RUN yum install -y java

VOlUME /tmp
ADD /spring-boot-web-0.0.1-SNAPSHOT.jar myapp.jar
RUN sh -c 'touch /myapp.jar'
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/myapp.jar"]
```

* 编译docker image.

```
docker build -t spring-boot-docker .
```

* 运行docker ``docker run -d -p 8080:8080 spring-boot-docker``

* docker ps 
* docker logs -f container_name  ,查看日志


