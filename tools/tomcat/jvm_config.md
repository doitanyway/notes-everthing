# jvm配置

# 配置

* 打开文件

```
[linux]# cd {tomcat_dir}
[linux]# vim bin/catalina.sh
```

* 在文件开始位置添加如下内容

```
JAVA_OPTS="-server
-Xms2048M
-Xmx2048M
-Xmn768M
-Xss1024K
-XX:PermSize=512M
-XX:MaxPermSize=512M
-Xnoclassgc
-XX:+DisableExplicitGC
-XX:+UseParNewGC
-XX:+UseConcMarkSweepGC
-XX:+UseCMSCompactAtFullCollection
-XX:CMSFullGCsBeforeCompaction=0
-XX:+CMSClassUnloadingEnabled
-XX:-CMSParallelRemarkEnabled
-XX:CMSInitiatingOccupancyFraction=38
-XX:SoftRefLRUPolicyMSPerMB=0
-XX:+PrintClassHistogram
-XX:+PrintGCDetails
-XX:+PrintGCTimeStamps
-XX:+PrintHeapAtGC
-Djazz.connector.sslProtocol=TLSv1.2
-Dcom.ibm.team.repository.transport.client.protocol=TLSv1.2
-Dcom.ibm.jsse2.sp800-131=strict
-Dcom.ibm.rational.rpe.tls12only=true
-Xloggc:../logs/gc.log"
```

## 启动验证

* 启动

```
[linux]# cd {tomcat_dir}
[linux]# ./bin/startup.sh
```

* 验证,如下所示，查询线程，能够看到刚才配置的参数。
```
[linux]# ps -ef | grep tomcat
root       6745   2758 73 00:48 pts/1    00:00:03 /usr/java/jdk1.8.0_151//bin/java -Djava.util.logging.config.file=/home/apache-tomcat-8.0.48/conf/logging.properties -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -server -Xms2048M -Xmx2048M -Xmn768M -Xss1024K -XX:PermSize=512M -XX:MaxPermSize=512M -Xnoclassgc -XX:+DisableExplicitGC -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:+UseCMSCompactAtFullCollection -XX:CMSFullGCsBeforeCompaction=0 -XX:+CMSClassUnloadingEnabled -XX:-CMSParallelRemarkEnabled -XX:CMSInitiatingOccupancyFraction=38 -XX:SoftRefLRUPolicyMSPerMB=0 -XX:+PrintClassHistogram -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintHeapAtGC -Djazz.connector.sslProtocol=TLSv1.2 -Dcom.ibm.team.repository.transport.client.protocol=TLSv1.2 -Dcom.ibm.jsse2.sp800-131=strict -Dcom.ibm.rational.rpe.tls12only=true -Xloggc:../logs/gc.log -Djdk.tls.ephemeralDHKeySize=2048 -Djava.protocol.handler.pkgs=org.apache.catalina.webresources -Dignore.endorsed.dirs= -classpath /home/apache-tomcat-8.0.48/bin/bootstrap.jar:/home/apache-tomcat-8.0.48/bin/tomcat-juli.jar -Dcatalina.base=/home/apache-tomcat-8.0.48 -Dcatalina.home=/home/apache-tomcat-8.0.48 -Djava.io.tmpdir=/home/apache-tomcat-8.0.48/temp org.apache.catalina.startup.Bootstrap start
root       6769   6456  0 00:48 pts/2    00:00:00 grep tomcat

```
