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
RUN \
   # mkdir /usr/local/rediscluster2&&\
   # cd /usr/local/rediscluster2&&\
   # wget http://download.redis.io/redis-stable.tar.gz && \
    cd /usr/local/rediscluster2/redis-2.8.16 &&\
    yum -y install gcc automake autoconf libtool make &&\
    make &&\
    makeinstall

WORKDIR /usr/local/rediscluster2
#COPY redis.sh /usr/local/redis.sh
EXPOSE 6379 6479 6579 26379
CMD ...
```
## 2 redis.conf配置文件加载
  ### 方式一：修改好redis.conf后通过dockerfile的ADD指令加入容器中
  ```

  ```
  
  ###方式二：在dockerfile的RUN指令中通过命令修改容器的redis.conf配置内容
  ```

   ```
## 3 如何将容器中的redis数据挂载到宿主机，保证容器的高可用
```angularjs

```
## 4 如何启动一个redis容器
```angularjs

```
