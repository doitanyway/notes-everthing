# 测试安装


## 安装tiup 

```bash 
curl --proto '=https' --tlsv1.2 -sSf https://tiup-mirrors.pingcap.com/install.sh | sh
```

* 生效环境变量 

```bash 
source .bash_profile
```

## 本地安装测试环境 

* 本地启动测试集群  
  * 启动最新的tidb集群（1个tidb，1个tikv，1个pd）
  ```bash 
  tiup playground
  ```
  * 指定tidb版本和个数
  ```bash 
  tiup playground v4.0.0 --db 2 --pd 3 --kv 3 --monitor
  ```

* 启动集群之后系统返回 
```bash 
nick@nicks-MacBook-Pro  ~/Desktop/study/notes-everything   master ●                tiup playground

Starting component `playground`: /Users/nick/.tiup/components/playground/v1.3.0/tiup-playground
Use the latest stable version: v4.0.9

    Specify version manually:   tiup playground <version>
    The stable version:         tiup playground v4.0.0
    The nightly version:        tiup playground nightly

Playground Bootstrapping...
Start pd instance
Start tikv instance
Start tidb instance
Waiting for tidb instances ready
Waiting for tidb instances ready
127.0.0.1:4000 ... Done
Start tiflash instance
Waiting for tiflash instances ready
127.0.0.1:3930 ... Done
CLUSTER START SUCCESSFULLY, Enjoy it ^-^
To connect TiDB: mysql --host 127.0.0.1 --port 4000 -u root
To view the dashboard: http://127.0.0.1:2379/dashboard
To view the Prometheus: http://127.0.0.1:53764
To view the Grafana: http://127.0.0.1:3000
```

* 执行如上命令之后可以使用``tiup list tidb``命令查看已经启动了的集群状态


* 连接mysql命令,默认密码为空

```bash 
mysql --host 127.0.0.1 --port 4000 -u root
```

* 访问Prometheus面板 http://127.0.0.1:53764/ .

* 访问tidb 仪表盘 http://127.0.0.1:2379/dashboard

* 范文grafana : http://127.0.0.1:3000

## 清理 


* ctl+c停止进程 

* 运行如下命令清理数据

```bash 
tiup clean --all
```


## 使用tiup在单台服务器上安装tidb

### 准备工作

* 服务器要求：
  * centos 7.3或者以上版本
  * 可以访问网络，能下载对应的安装包
  * 软件的root密码
  * 停止目标机的防火墙

* 集群配置

|Instance |	Count	|IP|	Configuration|
|--|--|--|--|
|TiKV	|3	|10.0.1.1<br>10.0.1.1<br>10.0.1.1|	Avoid conflict between the port and the directory|
|TiDB	|1|	10.0.1.1|	The default port,Global directory configuration|
|PD	|1|	10.0.1.1	|The default port,Global directory configuration|
|TiFlash	|1|	10.0.1.1	|The default port,Global directory configuration|
|Monitor	|1	|10.0.1.1|	The default port,Global directory configuration|

### 安装tiup 

* 安装tiup 

```bash 
curl --proto '=https' --tlsv1.2 -sSf https://tiup-mirrors.pingcap.com/install.sh | sh
```


* 生效环境变量 

```bash 
source .bash_profile
```

### 安装cluster

* 安装cluster组件

```bash 
tiup cluster
```

* 升级软件版本(可选)
```bash 
tiup update --self && tiup update cluster
```

* 修改ssh配置，增加最大连接数
  * 修改``/etc/ssh/sshd_config``, 配置MaxSessions为20.
  * 重启sshd ``service sshd restart``

* 创建并启动集群,先准备拓补文件``topo.yaml``

```yaml
# # Global variables are applied to all deployments and used as the default value of
# # the deployments if a specific deployment value is missing.
global:
 user: "tidb"
 ssh_port: 22
 deploy_dir: "/tidb-deploy"
 data_dir: "/tidb-data"

# # Monitored variables are applied to all the machines.
monitored:
 node_exporter_port: 9100
 blackbox_exporter_port: 9115

server_configs:
 tidb:
   log.slow-threshold: 300
 tikv:
   readpool.storage.use-unified-pool: false
   readpool.coprocessor.use-unified-pool: true
 pd:
   replication.enable-placement-rules: true
   replication.location-labels: ["host"]
 tiflash:
   logger.level: "info"

pd_servers:
 - host: 10.0.1.1

tidb_servers:
 - host: 10.0.1.1

tikv_servers:
 - host: 10.0.1.1
   port: 20160
   status_port: 20180
   config:
     server.labels: { host: "logic-host-1" }

 - host: 10.0.1.1
   port: 20161
   status_port: 20181
   config:
     server.labels: { host: "logic-host-2" }

 - host: 10.0.1.1
   port: 20162
   status_port: 20182
   config:
     server.labels: { host: "logic-host-3" }

tiflash_servers:
 - host: 10.0.1.1

monitoring_servers:
 - host: 10.0.1.1

grafana_servers:
 - host: 10.0.1.1
```

> * user: "tidb": 使用tidb系统用户(该用户在部署时会自动创建) 去内部管理集群. 默认情况下和目标机同学会使用22端口.
> * replication.enable-placement-rules: This PD parameter is set to ensure that TiFlash runs normally.
> host: 目标IP地址.

* 执行部署命令： 

```bash 
#tiup cluster deploy <cluster-name> <tidb-version> ./topo.yaml --user root -p
tiup cluster deploy cluster1 v4.0.9 ./topo.yaml --user root -p
```
> * ``<cluster-name>``: 设置集群名字
> * ``<tidb-version>``: 设置tidb cluster版本.可以使用命令``tiup list tidb`` 命令查看支持的tidb版本


* 输入 "y" 以及root的密码完成部署:

```bash 
Do you want to continue? [y/N]:  y
Input SSH password:
```

* 启动集群 
```bash 
tiup cluster start <cluster-name>
```

* 访问集群  
  * 安装mysql 客户端
  ```bash 
  yum -y install mysql
  # 默认密码是空，IP地址是任意一个TIDB的地址
  mysql -h 10.0.1.1 -P 4000 -u root
  ```

* 访问grafanna`` http://{grafana-ip}:3000``，默认用户是admin/admin

* 访问tidb 仪表盘`` http://{pd-ip}:2379/dashboard``，默认用户名root，密码为空

* 查询可部署的tidb版本

```bash 
tiup cluster list
```

* 查看cluster的拓补

```
tiup cluster display <cluster-name>
```


## 其他安装

[安装tidb生产集群](https://docs.pingcap.com/tidb/stable/production-deployment-using-tiup)
[离线安装tidb生产集群](https://docs.pingcap.com/tidb/stable/production-offline-deployment-using-tiup)
