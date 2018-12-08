
### 问题：
``Unable to round-trip http request to upstream:dial tcp xxx:i/o timeout``
如图：![在这里插入图片描述](https://img-blog.csdn.net/20181012153558672?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzMxNDI0ODI1/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

### 背景  
笔记是新买了阿里云很多东西没设置，搭建gitlab后发现不能访问gitlab页面，问题类图，以为是某些设置不对，或端口没开等；于是搭建tomcat来实验是否能访问；结果tomcat也不能访问；防火墙什么的都已搞定。

### 原因  
最后判定是阿里云安全组出入口端口设置没开，

### 解决  
阿里云分：公有ip与私有ip，公有ip需要设置；

设置路径：实例 --> 管理 --> 本实例安全组 --> 配置规则 --> 添加安全组规则
可以点击教我设置

![在这里插入图片描述](https://img-blog.csdn.net/20181012154532172?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzMxNDI0ODI1/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

![在这里插入图片描述](https://img-blog.csdn.net/20181012154552321?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzMxNDI0ODI1/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

设置后gitlab、tomcat正常访问


---------------------------------------------------------------
### 另附上防火墙设置：
在linux上开启的tomcat使用浏览器访问不了。
主要原因在于防火墙的存在，导致的端口无法访问。
CentOS7使用firewall而不是iptables。所以解决这类问题可以通过添加firewall的端口，使其对我们需要用的端口开放。

    1.使用命令  firewall-cmd --state查看防火墙状态。得到结果是running或者not running

2.在running 状态下，向firewall 添加需要开放的端口：

     命令为 firewall-cmd --permanent --zone=public --add-port=8080/tcp

 //永久的添加该端口。去掉--permanent则表示临时。

    4.firewall-cmd --reload //加载配置，使得修改有效。

    5.使用命令 firewall-cmd --permanent --zone=public --list-ports //查看开启的端口，出现8080/tcp这开启正确

6.再次使用外部浏览器访问，这出现tomcat的欢迎界面。

补充（CentOS7以下有专门的防火墙操作命令）：
开启防火墙的命令
     

    systemctl start firewalld.service

关闭防火墙的命令
   

     systemctl stop firewalld.service

开机自动启动
    

    systemctl enable firewalld.service

关闭开机自动启动
 

       systemctl disable firewalld.service

查看防火墙状态
   

     systemctl status firewalld下列显示表示没有问题。

--------------------- 
