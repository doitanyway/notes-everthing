# spring boot快速开始
本教程教读者快速建立一个Spring boot 项目；

## 我们将作什么
我们将会建立一个简单的spring boot应用；

## 需要什么
* 15分钟
* eclipse编译器
* jdk 1.8或者更高
* gradle 2.3+

## 创建目录结构
```
mkdir spring-demo
cd spring-demo
mkdir -p src/main/java/hello
```
## 创建gradle build文件
``build.gradle``
```
buildscript {
    repositories {
        mavenCentral()
    }
    dependencies {
        classpath("org.springframework.boot:spring-boot-gradle-plugin:1.5.6.RELEASE")
    }
}

apply plugin: 'java'
apply plugin: 'eclipse'
apply plugin: 'idea'
apply plugin: 'org.springframework.boot'

jar {
    baseName = 'gs-spring-boot'
    version =  '0.1.0'
}

repositories {
    mavenCentral()
}

sourceCompatibility = 1.8
targetCompatibility = 1.8

dependencies {
    // tag::jetty[]
    compile("org.springframework.boot:spring-boot-starter-web") {
        exclude module: "spring-boot-starter-tomcat"
    }
    compile("org.springframework.boot:spring-boot-starter-jetty")
    // end::jetty[]
    // tag::actuator[]
    compile("org.springframework.boot:spring-boot-starter-actuator")
    // end::actuator[]
    testCompile("junit:junit")
}
```
``spring boot gralde plugin``提供很多方便的特性：
* 收集所有在classpath的jar包，编译生成一个可执行的jar包，这使更方便的执行和传送你的服务；
* 寻找``public static void main()``方法作为一个可执行的类；
* 提供编译
