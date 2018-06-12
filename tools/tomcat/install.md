# tomcat安装

## 安装

* 安装好jdk,本文不重复介绍

* 下载tomcat
```
[linux]# wget http://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-7/v7.0.82/bin/apache-tomcat-7.0.82.tar.gz
[linux]# tar -xzvf apache-tomcat-8.5.24.tar.gz 
[linux]# mv apache-tomcat-8.5.24 tomcat_newname
```

其他版本： http://mirrors.shuosc.org/apache/tomcat/tomcat-8/v8.5.24/bin/apache-tomcat-8.5.24.tar.gz


* [配置防火墙](http://58.250.204.146:6002/fangle/notes-everthing/blob/master/Linux/content/iptables.md),打开80端口

* 配置tomcat端口
    * 进入tomcat目录``cd {tomcat dir}/``
    * ``vim conf/server.xml``
    * 在文件内搜索http协议的``Connector``，修改端口``<Connector port="80" protocol="HTTP/1.1" connectionTimeout="20000 redirectPort="8443"/>``
    * 其他Connector的端口保持与其他应用不重复即可；

* 测试启动tomcat
```
[linux]# cd {tomcat dir}
[linux]# ./bin/catalina.sh run
```

* 正常启动tomcat 

```
[linux]# cd {tomcat dir}
[linux]# ./bin/startup.sh 
```

## Trouble shooting

* 端口冲突，``conf/server.xml``里面出来有配置http端口以外，还有配置另外2个端口，在该文件中搜索port可以找到这2个端口，如果对应端口冲突，可以通过修改这个文件处理；
* [jvm优化](http://58.250.204.146:6002/fangle/notes-everthing/blob/master/tools/tomcat/jvm_config.md)
