# Docker打包Springboot项目

> 目标：用 Docker 的方式搭建一个 Java Spring Boot 应用


## 准备工作

操作前需要确保我们已经在本机上安装好了docker 以及docker compose


## 操作步骤

* 创建一个spring boot项目，引入web依赖

* 创建控制类测试使用

```java
@RestController
public class TestControler {
    @RequestMapping("/")
    String index(){
        return "hello docker";
    }
}
```

* 创建Dockerfile

```Dockerfile
FROM java:8-jdk-alpine

ADD target/demo-*.jar /app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","/app.jar"]
```


* 创建编译脚本build.sh

```bash
#!/usr/bin/env bash 
#mvn package 
docker build -t demo-spring:v1.0 . 
#docker run -d -p 8080:8080 demo-spring 
#docker tag demo-spring:v1.0 qiujiahong/demo-spring:1.0 
#docker push qiujiahong/demo-spring:1.0
```

* 运行容器

```
docker run  -p 8080:8080 demo-spring:v1.0
```

* 后台运行容器

```
docker run -d -p 8080:8080 demo-spring:v1.0
```