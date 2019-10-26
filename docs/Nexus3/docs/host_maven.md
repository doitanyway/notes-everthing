# host maven仓库


nexus 3安装好之后默认有三个maven仓库；  
* maven-central, prox类型，在线的远程仓库
* maven-release, hosted类型，存放稳定版
* maven-snapshots,hosted类型，存放开发版；
* maven-public,group类型；汇聚了前面三个仓库，这样客户端只需要配置一个地址，就能访问到上面三个仓库的包；  


## 配置  

* maven的settings文件,此处配置了servers，mirrors和profiles

```xml
<?xml version="1.0" encoding="UTF-8"?>

<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">
 
  <pluginGroups>
  </pluginGroups>

  <proxies>
   
  </proxies>

  <servers>
    <server>
      <id>nexus-snapshots</id>
      <username>admin</username>
      <password>admin</password>
    </server>
    <server>
      <id>nexus-releases</id>
      <username>admin</username>
      <password>admin</password>
    </server>
     <server>
      <id>nexus_public</id>
      <username>admin</username>
      <password>admin</password>
    </server>

  </servers>


  <mirrors>
  <mirror>
      <id>nexus</id>
      <mirrorOf>*</mirrorOf>
      <url>http://127.0.0.1:8081/repository/maven-public/</url>
    </mirror>
  </mirrors>

  <profiles>
    <profile>
      <activation>
        <activeByDefault>true</activeByDefault>
      </activation>
      <repositories>
        <repository>
          <id>nexus_public</id>
          <name>Nexus Public Repository</name>
          <url>http://127.0.0.1:8081/repository/maven-public/</url>
          <releases>
            <enabled>true</enabled>
          </releases>
          <snapshots>
            <enabled>true</enabled>
            <updatePolicy>always</updatePolicy>
          </snapshots>
        </repository>
      </repositories>
    </profile>
  </profiles>

</settings>


```

* 配置工程的pom.xml

```xml
    <repositories>
        <repository>
            <id>nexus_public</id>
            <name>maven-public</name>
            <url>http://127.0.0.1:8081/repository/maven-public/</url>
        </repository>
    </repositories>
    <distributionManagement>
        <repository>
            <id>nexus-releases</id>
            <name>maven-releases</name>
            <url>http://127.0.0.1:8081/repository/maven-releases/</url>
        </repository>
        <snapshotRepository>
            <id>nexus-snapshots</id>
            <name>maven-snapshots</name>
            <url>http://127.0.0.1:8081/repository/maven-snapshots/</url>
        </snapshotRepository>
    </distributionManagement>
```

> ``repositories[].repository.id`` 以及``distributionManagement.repository.id`` 、``distributionManagement.snapshotRepository.id``需要和``servers[].server.id``的值对应。
