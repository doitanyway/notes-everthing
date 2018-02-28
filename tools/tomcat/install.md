# tomcat安装

* 安装好jdk,本文不重复介绍

* 下载tomcat
```
[linux]# wget http://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-7/v7.0.82/bin/apache-tomcat-7.0.82.tar.gz
[linux]# tar -xzvf apache-tomcat-8.5.24.tar.gz 
[linux]# mv apache-tomcat-8.5.24 tomcat_newname
```
其他版本： http://mirrors.shuosc.org/apache/tomcat/tomcat-8/v8.5.24/bin/apache-tomcat-8.5.24.tar.gz


* 配置防火墙
    * 打开文件``vim /etc/sysconfig/iptables``
    * 加一行``-A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT``,打开80端口访问权限；
    * 重启防火墙,``service iptables restart``

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

