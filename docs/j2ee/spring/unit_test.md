# 单元测试 {ignore=true}


<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->
<!-- code_chunk_output -->

* [简介](#简介)
* [开发环境](#开发环境)
* [详细步骤](#详细步骤)
	* [新建项目](#新建项目)
	* [新建控制类](#新建控制类)
	* [新建应用程序类](#新建应用程序类)
	* [查看效果](#查看效果)
	* [添加测试功能](#添加测试功能)
	* [执行测试](#执行测试)
* [总结](#总结)

<!-- /code_chunk_output -->


## 简介

本文介绍基于gradle的spring项目，如何进行单元测试。

## 开发环境

* gradle
* eclipse
* git 
* jdk 1.8 
* windows 10

## 详细步骤

### 新建项目

* 新建目录
    ```
    mkdir web-test
    ```

* 初始化gradle项目
    ```
    cd web-test
    gradle init --type java-application
    ```

* 使用eclipse导入该gradle项目

### 新建控制类

``src/main/java/hello/HomeController.java``
```java
package hello;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HomeController {

    @RequestMapping("/")
    public @ResponseBody String greeting() {
        return "Hello World";
    }

}
```

### 新建应用程序类

``src/main/java/hello/Application.java``
```java
package hello;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class Application {

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}
```

### 查看效果

* 编译执行程序
    ```
    ./gradlew build && java -jar build/libs/gs-testing-web-0.1.0.jar
    ```

* 网页查看效果  
    ![](assets/2017-09-29-19-32-09.png)

### 添加测试功能

* 添加应用测试类
    空测试``src/test/java/hello/ApplicationTest.java``  
    ```java
    package hello;

    import org.junit.Test;
    import org.junit.runner.RunWith;
    import org.springframework.boot.test.context.SpringBootTest;
    import org.springframework.test.context.junit4.SpringRunner;

    @RunWith(SpringRunner.class)
    @SpringBootTest
    public class ApplicationTest {

        @Test
        public void contextLoads() throws Exception {
        }

    }
    ```

    ``src/test/java/hello/SmokeTest.java``，测试控制器是否能够正常导入  
    ```java
    package hello;

    import static org.assertj.core.api.Assertions.assertThat;

    import org.junit.Test;
    import org.junit.runner.RunWith;
    import org.springframework.beans.factory.annotation.Autowired;
    import org.springframework.boot.test.context.SpringBootTest;
    import org.springframework.test.context.junit4.SpringRunner;

    @RunWith(SpringRunner.class)
    @SpringBootTest
    public class SmokeTest {

        @Autowired
        private HomeController controller;

        @Test
        public void contexLoads() throws Exception {
            assertThat(controller).isNotNull();
        }
    }
    ```

    http测试``src/test/java/hello/HttpRequestTest.java``,接收http测试，看返回值是是期望值  
    ```java
    package hello;

    import static org.assertj.core.api.Assertions.assertThat;

    import org.junit.Test;
    import org.junit.runner.RunWith;
    import org.springframework.beans.factory.annotation.Autowired;
    import org.springframework.boot.context.embedded.LocalServerPort;
    import org.springframework.boot.test.context.SpringBootTest;
    import org.springframework.boot.test.context.SpringBootTest.WebEnvironment;
    import org.springframework.boot.test.web.client.TestRestTemplate;
    import org.springframework.test.context.junit4.SpringRunner;

    @RunWith(SpringRunner.class)
    @SpringBootTest(webEnvironment = WebEnvironment.RANDOM_PORT)
    public class HttpRequestTest {

        @LocalServerPort
        private int port;

        @Autowired
        private TestRestTemplate restTemplate;

        @Test
        public void greetingShouldReturnDefaultMessage() throws Exception {
            assertThat(this.restTemplate.getForObject("http://localhost:" + port + "/",
                    String.class)).contains("Hello World");
        }
    }
    ```

### 执行测试

如下，未报错，执行成功；
```
$ ./gradlew test
:compileJava
:processResources NO-SOURCE
:classes
:compileTestJava
:processTestResources NO-SOURCE
:testClasses
:test
2017-09-29 19:53:05.942  INFO 1068 --- [       Thread-8] ationConfigEmbeddedWebApplicationContext : Closing org.springframework.boot.context.embedded.AnnotationConfigEmbeddedWebApplicationContext@1d1f356c: startup date [Fri Sep 29 19:53:05 CST 2017]; root of context hierarchy
2017-09-29 19:53:05.942  INFO 1068 --- [       Thread-5] o.s.w.c.s.GenericWebApplicationContext   : Closing org.springframework.web.context.support.GenericWebApplicationContext@66a88583: startup date [Fri Sep 29 19:53:03 CST 2017]; root of context hierarchy

BUILD SUCCESSFUL in 4s
3 actionable tasks: 3 executed
```


## 总结

注解：  

| 名称                 | 作用                                                              |
|----------------------|-------------------------------------------------------------------|
| @Controller          | 控制类，类前                                                       |
| @RequestMapping("/") | 请求路径，在函数前                                                 |
| @SpringBootTest      | 该注解告诉测试去寻找配置好的main类(带注解：@SpringBootApplication) |

更多的详细内容请参考：https://docs.spring.io/spring/docs/current/spring-framework-reference/#spring-mvc-test-server-htmlunit
