# 安装高可用zk


## 安装jdk 

* 解压jar包到
```bash
# java -version  命令检查该主机上是否已经安装java，如果已经安装则跳过该步骤 
cd /root/apps/
mkdir -p /app/
tar -xzvf jdk-8u231-linux-x64.tar.gz  -C /app/
```

* 编辑文件: ``vim /etc/profile``,末尾添加： 

```BASH
export JAVA_HOME=/app/jdk1.8.0_231
export PATH=$JAVA_HOME/bin:$PATH
```
* 执行生效java环境变量 

```bash
source /etc/profile
```

* 验证java是否安装成功,如下命令，如果返回正常版本则表明安装成功。  
```bash
java -version
```


## 安装zk

```bash 
cd /root/apps/
mkdir -p /app/
# 添加用户、用户组,如果用户或者用户组已经存在，则忽略这两句  
groupadd appuser
useradd -g appuser appuser
tar -xzvf apache-zookeeper-3.5.6-bin.tar.gz -C /app/
cd /app/apache-zookeeper-3.5.6-bin/conf/
cp zoo_sample.cfg zoo.cfg
mkdir -p  /app/apache-zookeeper-3.5.6-bin/data
chown -R appuser:appuser /app/apache-zookeeper-3.5.6-bin
sed -i "s/^dataDir.*/#dataDir=/g" /app/apache-zookeeper-3.5.6-bin/conf/zoo.cfg
```

* 修改配置文件，``vim  /app/apache-zookeeper-3.5.6-bin/conf/zoo.cfg``,添加如下列

```bash
dataDir=/app/apache-zookeeper-3.5.6-bin/data
dataLogDir=/app/apache-zookeeper-3.5.6-bin/logs

server.1=10.200.200.11:2888:3888
server.2=10.200.200.21:2888:3888
server.3=10.200.200.26:2888:3888
```

* 启动应用 

```bash
su appuser
cd /app/apache-zookeeper-3.5.6-bin
# 不同节点该数字不一样 
echo 1 > data/myid
# echo 2 > data/myid
# echo 3 > data/myid
./bin/zkServer.sh start
```

* 检查状态

```bash 
./bin/zkServer.sh status
```