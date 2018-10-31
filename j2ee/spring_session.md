# spring session 

## 前言

本文演示如何使用spring session，实现登陆功能，使用redis存储session。

* spring 版本： 2.1.0.RELEASE
* jdk1.8



## 代码

* pom.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.nick</groupId>
    <artifactId>sessiondemo</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <packaging>jar</packaging>

    <name>sessiondemo</name>
    <description>Demo project for Spring Boot</description>

    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.1.0.RELEASE</version>
        <relativePath/> <!-- lookup parent from repository -->
    </parent>

    <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
        <java.version>1.8</java.version>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <optional>true</optional>
        </dependency>
        <dependency>
            <groupId>org.springframework.session</groupId>
            <artifactId>spring-session-data-redis</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-redis</artifactId>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>
```

* application.yaml

```yaml
spring:
  redis:
    host: 127.0.0.1
    port: 6379
    jedis:
      pool:
        max-active: 50
        max-idle: 8
        min-idle: 0
```

* SessiondemoApplication   
```java
package com.nick.sessiondemo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class SessiondemoApplication {

    public static void main(String[] args) {
        SpringApplication.run(SessiondemoApplication.class, args);
    }
}
```

* SessionConf 配置

```java
package com.nick.sessiondemo;

import org.springframework.context.annotation.Configuration;
import org.springframework.session.data.redis.config.annotation.web.http.EnableRedisHttpSession;

@Configuration//配置类
@EnableRedisHttpSession(maxInactiveIntervalInSeconds = 3000)//配置session的过期时间
public class SessionConf {
}
```

* 控制测试类 SessionController

```java
package com.nick.sessiondemo;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;


//@Controller
@Slf4j
@RestController
public class SessionController {
    @Autowired
    private RedisTemplate redisTemplate;

    @Autowired
    ObjectMapper objectMapper;

    private User user = new User("nick",30);

    @RequestMapping("set")
    public String setSession(HttpServletRequest req) throws JsonProcessingException {
        String sessionID = req.getSession().getId();
        redisTemplate.opsForValue().set(sessionID,sessionID);
        redisTemplate.opsForValue().set("user",objectMapper.writeValueAsString(user));
        System.out.println(req.getSession().getId());
        return "session";
    }
    @RequestMapping("get")
    public String getSession(HttpServletRequest req) throws JsonProcessingException {
        String ret;
        String sessionID = req.getSession().getId();
        System.out.println(req.getSession().getId());
        Object obj= redisTemplate.opsForValue().get(sessionID);
        Object user= redisTemplate.opsForValue().get("user");
        if (obj ==null){
            ret = "没有登录";
        }else {
            ret = "已经登录:"+objectMapper.writeValueAsString(user);
            log.info(ret);
        }
        return ret;
    }
}
```

* 用户类

```java
@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {
    private String name;
    private Integer age;

}
```