# maven更换国内镜像

使用maven或者gradle的时候经常遇到下载速度过慢的情况，需要更新国内镜像，只需修改pom.xml文件，添加如下内容即可：

```xml
    <repositories>
		<repository>
			<id>nexus-aliyun</id>
			<name>Nexus aliyun</name>
			<url>http://maven.aliyun.com/nexus/content/groups/public</url>
		</repository>
	</repositories>

	<pluginRepositories>
		<pluginRepository>
			<id>nexus-aliyun</id>
			<name>Nexus aliyun</name>
			<url>http://maven.aliyun.com/nexus/content/groups/public</url>
		</pluginRepository>
	</pluginRepositories>
```