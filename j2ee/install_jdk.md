# 安装jdk


## 准备工作

* 安装好的centos 操作系统
* 安装好unzip,vim软件（``yum install -y unzip vim`` ）。
* 从百度云盘下载安装软件，https://pan.baidu.com/s/1x3p091WHpZsceZ1wY9DdtQ 密码：w67b，并上传到指定目录(本文假设是``/home/soft``


## 安装jdk

* 解压文件  
```
cd /home/soft
unzip software.zip
rpm -ivh jdk-7u80-linux-x64.rpm
```

* 配置环境变量，``vim /root/.bash_profile ``

删除： 

```
PATH=$PATH:$HOME/bin

export PATH
```

添加： 

```
JAVA_HOME=/usr/java/jdk1.7.0_80
PATH=$JAVA_HOME/bin:$PATH
CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
export JAVA_HOME PATH CLASSPATH
```

* ``source /root/.bash_profile``

* 验证jdk是否安装好,如果显示对应的java 版本则安装完成。

```
java -version
```