* 问题描述：道路系统时间与操作系统时间不一致  
* 问题原因：当前环境下JAVA所使用的时区（默认时区为：Etc/UTC）与操作系统不一致  
* 解决办法：Tomcat启动时指定时区
 1. 修改tomcat/bin/catalina.sh文件；
 2. 在文件中添加启动参数,指定时间为北京时区：   
    <code>set JAVA_OPTS="-Duser.timezone=GMT+08"</code>
 3. 然后重启服务器，即可解决此问题。