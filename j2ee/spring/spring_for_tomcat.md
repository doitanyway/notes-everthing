# spring生成可部署在tomcat的war包

## 简介

生产环境经常需要生成war包部署到tomcat下面，但是我们spring的gradle项目，默认情况下是生成jar包的。本文说明如何生成可在tomcat下部署的war包。


## 操作步骤

* 修改``build.gradle``文件,加入``apply plugin: 'war'``插件，加入``providedRuntime("org.springframework.boot:spring-boot-starter-tomcat")``依赖  

```
...
apply plugin: 'war'

war {
    baseName = 'myapp'
    version =  '0.5.0'
}

repositories {
    jcenter()
    maven { url "http://repo.spring.io/libs-snapshot" }
}

dependencies {
    compile("org.springframework.boot:spring-boot-starter-web")
    providedRuntime("org.springframework.boot:spring-boot-starter-tomcat")
    ...
}
```

* 修改main 类,重写``configure``函数。

```java
@SpringBootApplication
public class SSOApplication extends SpringBootServletInitializer{

    public static void main(String[] args) {
        SpringApplication.run(SSOApplication.class, args);
    }

    /**
     *重写configure
     * @param builder
     * @return
     */
    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        return builder.sources(SSOApplication.class);
    }
}
```