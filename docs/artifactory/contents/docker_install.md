#  artifactory docker安装


## 安装 

```BASH
# 下载镜像
docker pull docker.bintray.io/jfrog/artifactory-oss:6.12.1  
# 1.运行镜像
docker run --name artifactory -d -p 8081:8081 docker.bintray.io/jfrog/artifactory-oss:6.12.1  

# 2.设置JVM参数运行镜像
 docker run --name artifactory -d -p 8081:8081 \
 -e EXTRA_JAVA_OPTIONS='-Xms512m -Xmx2g -Xss256k -XX:+UseG1GC' \
  docker.bintray.io/jfrog/artifactory-oss:6.12.1  

# 3.使用docker名称volume运行镜像
docker volume create --name artifactory_data 
docker run --name artifactory-oss -d \
   -v artifactory_data:/var/opt/jfrog/artifactory \
   -p 8081:8081 \
   docker.bintray.io/jfrog/artifactory-oss:6.12.1  

# 4.使用docker主机目录运行镜像
docker run --name artifactory-oss \
  -d -v /var/opt/jfrog/artifactory:/var/opt/jfrog/artifactory \
  -p 8081:8081 \
   docker.bintray.io/jfrog/artifactory-oss:6.12.1  
```


## 环境变量支持

```BASH 
# 可以如下命令传递环境变量
docker run -d --name art \
    -e SERVER_XML_ARTIFACTORY_MAX_THREADS=500 \
    -p 8081:8081 docker.bintray.io/jfrog/artifactory-pro:6.12.1
```

* Tomcat Server.xml相关变量

|变量|作用|默认值|
|--|--|--|
|SERVER_XML_EXTRA_CONNECTOR|给tomcat添加额外的connector. 如SSL支持.	|
|SERVER_XML_ARTIFACTORY_PORT |自定义服端口.	|8081||
|SERVER_XML_ARTIFACTORY_MAX_THREADS|最大线程数.	|200|
|SERVER_XML_ARTIFACTORY_EXTRA_CONFIG|添加额外的 Artifactory connector配置.	|
|SERVER_XML_ACCESS_MAX_THREADS|自定义访问线程数.	|50|
|SERVER_XML_ACCESS_EXTRA_CONFIG|添加额外的Access connector配置||

## 持久化存储劵

* 使用主机目录  

```BASH 
docker run --name artifactory-oss \
  -d -v /var/opt/jfrog/artifactory:/var/opt/jfrog/artifactory \
  -p 8081:8081 \
   docker.bintray.io/jfrog/artifactory-oss:6.12.1  

```

* 使用docker名称volume 

```bash
docker volume create --name artifactory_data 
docker run --name artifactory-oss -d \
   -v artifactory_data:/var/opt/jfrog/artifactory \
   -p 8081:8081 \
   docker.bintray.io/jfrog/artifactory-oss:6.12.1  
```

