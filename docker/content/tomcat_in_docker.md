# 构建tomcat8+jdk1.8基础镜像
##dockerfile
```
FROM centos

# OS环境配置
RUN yum install -y wget

# 安装JDK
RUN mkdir /var/tmp/jdk
RUN cd /var/tmp/jdk
RUN  wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u141-b15/336fa29ff2bb4ef291e347e091f7f4a7/jdk-8u141-linux-x64.tar.gz"
RUN tar xzf /var/tmp/jdk/jdk* -C /var/tmp/jdk && rm -rf /var/tmp/jdk/jdk-8u141-linux-x64.tar.gz

# 安装tomcat
RUN mkdir /var/tmp/tomcat
RUN wget -P  /var/tmp/tomcat http://archive.apache.org/dist/tomcat/tomcat-8/v8.5.8/bin/apache-tomcat-8.5.8.tar.gz
RUN tar xzf /var/tmp/tomcat/apache-tomcat-8.5.8.tar.gz -C /var/tmp/tomcat && rm -rf /var/tmp/tomcat/apache-tomcat-8.5.8.tar.gz
#优化tomcat
#设置环境变量
ENV JAVA_HOME /var/tmp/jdk/jdk1.8.0_141
ENV CATALINA_HOME /var/tmp/tomcat/apache-tomcat-8.5.8
ENV PATH $PATH:$JAVA_HOME/bin:$CATALINA_HOME/bin

#打包项目并拷贝到tomcat webapps目录
#RUN mkdir /var/tmp/webapp
#ADD ./  /var/tmp/webapp
#RUN cd  /var/tmp/webapp  && cp /var/tmp/webapp/war/sm_new.war /var/tmp/tomcat/apache-tomcat-8.5.8/webapps/

#开启内部服务端口
EXPOSE 8080

#启动tomcat服务器
CMD ["./var/tmp/tomcat/apache-tomcat-8.5.8/bin/catalina.sh","run"] && tail -f /var/tmp/tomcat/apache-tomcat-8.5.8/logs/catalina.out

```
##启动容器
```
#docker build -t tomcat_jdk:0.1 .
#docker run -it -p 8080:8080 --name=tomcat8-jdk1.8  镜像id
```