# 安装高可用es


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


## 安装es

```bash
cd /root/apps/
mkdir -p /app/
tar -xzvf elasticsearch-5.5.0.tar.gz  -C /app/
cp -rf ik /app/elasticsearch-5.5.0/plugins
# 添加用户、用户组,如果用户或者用户组已经存在，则忽略这两句  
groupadd appuser
useradd -g appuser appuser
chown -R appuser:appuser /app/elasticsearch-5.5.0
```



* 配置文件 ``vi /etc/sysctl.conf`` 文件最后添加一行

```bash
vm.max_map_count=262144
```

```bash
# 加载设置好的系统参数sysctl [-n] [-e] -p <filename> (default /etc/sysctl.conf)
sysctl -p
```

* 配置文件``vim /etc/security/limits.conf``,增加如下配置

```bash 
*               soft    nofile          65536
*               hard    nofile          65536
*               soft    nproc           4096
*               hard    nproc           4096

```
>  参数用户重新登录生效，检查命令：``ulimit -Hn``,``ulimit -Sn``,``ulimit -Hu``,``ulimit -Su``


* 编辑文件  ``vim /app/elasticsearch-5.5.0/config/elasticsearch.yml``,末尾添加入下配置:

```yaml
network.host: 0.0.0.0
cluster.name: elasticsearch
# ha parameters.
## node name . make sure every node have different name. 
node.name: node-1
# change the ip address 
discovery.zen.ping.unicast.hosts: ["10.200.200.11:9300", "10.200.200.21:9300", "10.200.200.26:9300"]
discovery.zen.minimum_master_nodes: 1
node.master: true
node.data: true
```


* 启动


```bash
su appuser
cd /app/elasticsearch-5.5.0/
# ./bin/elasticsearch  可以先使用前台启动命令测试启动是否成功
./bin/elasticsearch -d
# 查看日志
tail -f logs/elasticsearch.log 
```

## 验证

```bash
# 查看java进程
jps
# es服务
curl http://127.0.0.1:9200
# 命令帮助
curl http://127.0.0.1:9200/_cat
# 检查nodes状态
curl http://127.0.0.1:9200/_cat/nodes
```
