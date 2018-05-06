# 使用docker file template

使用上一节的资源。

* 修改文件名``Dockerfile``为``DockerfileTemplate``

* 编辑``DockerfileTemplate``

```
FROM openjdk

VOLUME /tmp
ADD maven/${fileName}.jar ${fileName}.jar
RUN sh -c 'touch /myapp.jar'
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/${fileName}.jar"]
```

* 添加脚本``src/main/scripts/BuildDockerfile.groovy``

```groovy 
String template = new File("${project.basedir}/src/main/docker/DockerfileTemplate".toString()).getText()

def dockerFileText = new groovy.text.SimpleTemplateEngine().createTemplate(template)
        .make([fileName: project.build.finalName])

println "writing dir " + "${project.basedir}/target/dockerfile"
new File("${project.basedir}/target/dockerfile/".toString()).mkdirs()


println "writing file"
File dockerFile = new File("${project.basedir}/target/dockerfile/Dockerfile".toString())


dockerFile.withWriter('UTF-8') { writer ->
    writer.write(dockerFileText)
}
```

* 修改pom文件，添加插件，修改dockerfile路径

```xml
 <plugin>
                <groupId>org.codehaus.gmavenplus</groupId>
                <artifactId>gmavenplus-plugin</artifactId>
                <version>1.5</version>
                <executions>
                    <execution>
                        <phase>prepare-package</phase>
                        <goals>
                            <goal>execute</goal>
                        </goals>
                    </execution>
                </executions>
                <configuration>
                    <scripts>
                        <script>file:///${project.basedir}/src/main/scripts/BuildDockerfile.groovy</script>
                    </scripts>
                </configuration>
                <dependencies>
                    <dependency>
                        <groupId>org.codehaus.groovy</groupId>
                        <artifactId>groovy-all</artifactId>
                        <!-- any version of Groovy \>= 1.5.0 should work here -->
                        <version>2.4.8</version>
                        <scope>runtime</scope>
                    </dependency>
                </dependencies>
            </plugin>
```

```xml
<dockerFileDir>${project.basedir}/target/dockerfile</dockerFileDir>
```

* 执行编译： mvn clean package docker:build

* 执行推送新版本到docker hub：mvn clean package docker:build docker:push

https://github.com/qiujiahong/spring-boot-docker/tree/dockertemplate
# 构建redis镜像的dockerfile详解
## 1 构建redis镜像的dockerfile编写
```
FROM centos
#WORKDIR /usr/local/rediscluster

ADD redis-2.8.16.tar.gz /usr/local/rediscluster
ADD redis.conf /usr/local/rediscluster
ADD redis2.conf /usr/local/rediscluster
ADD redis3.conf /usr/local/rediscluster
ADD sentinel.conf /usr/local/rediscluster
ADD redis.sh /usr/local/rediscluster
ENV REDISPATH /usr/local/rediscluster
WORKDIR $REDISPATH
RUN \
    mkdir /var/redis/data &&\
   # cd /usr/local/rediscluster&&\
   # wget http://download.redis.io/redis-stable.tar.gz && \
    chmod +x /usr/local/rediscluster/redis.sh
    cd /usr/local/rediscluster/redis-2.8.16 &&\
    yum -y install gcc automake autoconf libtool make &&\
    make &&\
    make install

#http://download.redis.io/releases/redis-2.8.16.tar.gz
#RUN tar xvf -C redis-2.8.16.tar.gz
#-C /usr/local/ && mv /usr/local/redis-2.8.16/ /usr/local/redis
#RUN wget http://code.taobao.org/svn/openclouddb/downloads/old/MyCat-Sever-1.2/Mycat-server-1.2-GA-linux.tar.gz
#COPY redis.sh /usr/local/redis.sh

EXPOSE 6379 6479 6579 26379
#ENTRYPOINT ["redis.sh"]
#ENTRYPOINT ["redis-server", "/etc/redis/sentinel.conf", "--sentinel"]
#CMD /bin/sh
CMD ["sh","redis.sh"]
```
## 2 redis.sh
  ```
#!/bin/sh
exec /usr/local/bin/redis-server /usr/local/rediscluster/redis.conf &
exec /usr/local/bin/redis-server /usr/local/rediscluster/redis2.conf &
exec /usr/local/bin/redis-server /usr/local/rediscluster/redis3.conf &
exec /usr/local/bin/redis-server /usr/local/rediscluster/sentinel.conf --sentinel
  ```
## 3 建立镜像
```
docker build -it redis2.8:v1 .
```
## 4 启动容器
```
docker run --name redis_v1 -it [redis镜像id]

```
