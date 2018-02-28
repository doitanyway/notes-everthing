# 添加fabric插件到plugin


* 准备一个spring boot maven 工程

* pom.xml 中添加docker-maven-plugin以及一些变量

```xml
	<properties>
		<project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
		<java.version>1.8</java.version>

		<!--set this to your docker acct name-->
        <!--<docker.image.prefix>springframeworkguru</docker.image.prefix>-->
        <docker.image.prefix>qiujiahong</docker.image.prefix>

		<!--Set to name of project-->
		<docker.image.name>springbootdocker</docker.image.name>

	</properties>
```

```xml
<plugins>
			<plugin>
				<groupId>org.springframework.boot</groupId>
				<artifactId>spring-boot-maven-plugin</artifactId>
			</plugin>
			<plugin>
				<groupId>io.fabric8</groupId>
				<artifactId>docker-maven-plugin</artifactId>
				<version>0.20.2</version>

				<configuration>

					<!--<dockerHost>http://127.0.0.1:2375</dockerHost>-->
					<dockerHost>unix:///var/run/docker.sock</dockerHost>

					<verbose>true</verbose>
					<images>
						<image>
							<name>${docker.image.prefix}/${docker.image.name}</name>
							<build>
								<dockerFileDir>${project.basedir}/src/main/docker/</dockerFileDir>

								<!--copies artficact to docker build dir in target-->
								<assembly>
									<descriptorRef>artifact</descriptorRef>
								</assembly>
								<tags>
									<tag>latest</tag>
									<tag>${project.version}</tag>
								</tags>
							</build>
						</image>
					</images>
				</configuration>
			</plugin>
		</plugins>
```


* 创建Dockerfile src/main/docker/Dockerfile

```
FROM openjdk

VOLUME /tmp
ADD maven/spring-boot-docker-0.0.1-SNAPSHOT.jar myapp.jar
RUN sh -c 'touch /myapp.jar'
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/myapp.jar"]
```


* 编译 ``mvn clean package docker:build``

* 查看生成的image ``docker images``  

![](./assets/2018-02-23-12-49-41.png)