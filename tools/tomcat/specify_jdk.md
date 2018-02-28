# 指定JDK运行tomcat

## 前言

通过本文，读者可以知道怎么让TOMCAT使用，指定版本的JDK运行程序。本文的运行环境是CENTOS 6。

## 下载JDK

```
[linux]# wget http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-x64.rpm
```

## 安装文件

执行下面命令安装，安装好之后jdk默认在目录``/usr/java/jdk1.8.0_151``

```
[linux]# rpm -ivh jdk-8u151-linux-x64.rpm
```

## 配置jdk

```
[linux]# cd {tomcat dir}
[linux]# vim bin/catalina.sh
```
在文件的开始位置，添加``export JAVA_HOME="/usr/java/jdk1.8.0_151/"``,版本号和路径以实际为准。

## 启动验证

```
[linux]# cd {tomcat dir}
[linux]# ./bin/startup.sh
[linux]# ps -ef | grep tomcat 
root       6646   2758 95 00:41 pts/1    00:00:03 /usr/java/jdk1.8.0_151//bin/java -Djava.util.logging.config.file=/home/apache-tomcat-8.0.48/conf/logging.properties -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -Djdk.tls.ephemeralDHKeySize=2048 -Djava.protocol.handler.pkgs=org.apache.catalina.webresources -Dignore.endorsed.dirs= -classpath /home/apache-tomcat-8.0.48/bin/bootstrap.jar:/home/apache-tomcat-8.0.48/bin/tomcat-juli.jar -Dcatalina.base=/home/apache-tomcat-8.0.48 -Dcatalina.home=/home/apache-tomcat-8.0.48 -Djava.io.tmpdir=/home/apache-tomcat-8.0.48/temp org.apache.catalina.startup.Bootstrap start
root       6667   6456  0 00:41 pts/2    00:00:00 grep tomcat

```

如上所示，显示使用的JDK 为1.8.0_151