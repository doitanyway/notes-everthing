# scala安装



## 二进制安装

* 下载对应版本的scala,笔者选择``2.11.12``
https://www.scala-lang.org/download/all.html


* 配置环境变量  

```bash 
sed -i "/SCALA_HOME_VAR/d" /etc/profile
echo "export SCALA_HOME=/usr/local/scala # SCALA_HOME_VAR"  >> /etc/profile 
echo "export PATH=\$PATH:\$SCALA_HOME/bin # SCALA_HOME_VAR"  >> /etc/profile 
source /etc/profile
```


## sdkmain 安装 

```bash 
sdk install scala 2.11.12
```


## 测试

命令行输入``scala -version``验证scala的版本