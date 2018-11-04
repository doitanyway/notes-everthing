##  emq安装


### 安装emq 

* 安装需要安装的软件

```
yum install -y vim unzip wget 
```

* 下载emq，到[官网](http://emqtt.com/downloads)找到响应版本

```
wget --no-check-certificate  https://www.emqx.io/static/brokers/emqx-centos7-v3.0-rc.2.zip
```

* 解压安装 

```
# 需要提前安装unzip, yum install -y unzip 
unzip emqx-centos7-v3.0-rc.2.zip 
mv emqx /usr/local/
cd /usr/local/emqx/
```

* 修改配置文件``vim etc/emqx.conf `` ,ip地址根据实际情况配置  
```
...
node.name = emqx@192.168.3.100
...
```

*  启动软件
```
cd /usr/local/emqx/
./bin/emqx start 
# 检查运行状态
./bin/emqx_ctl status
```

* 配置防火墙   

| 端口  | 用途                     | 配置字段                 | 配置文件                         |
|-------|------------------------|--------------------------|----------------------------------|
| 1883  | MQTT 协议端口            | listener.tcp.external    | etc/emqx.conf                    |
| 8883  | MQTT/SSL 端口            | listener.ssl.external    | etc/emqx.conf                    |
| 8083  | MQTT/WebSocket 端口      | listener.ws.external     | etc/emqx.conf                    |
| 8080  | HTTP API 端口  -- 没找到 | management.listener.http | etc/plugins/emqx_management.conf |
| 18083 | Dashboard 管理控制台端   | dashboard.listener.http  | etc/plugins/emqx_dashboard.conf  |

```
firewall-cmd --zone=public --add-port=1883/tcp --permanent
firewall-cmd --zone=public --add-port=8883/tcp --permanent
firewall-cmd --zone=public --add-port=8083/tcp --permanent
firewall-cmd --zone=public --add-port=8080/tcp --permanent
firewall-cmd --zone=public --add-port=18083/tcp --permanent
firewall-cmd --reload 
```

* 网页访问验证安装  http://192.168.3.100:18083   

![](./assets/2018-11-04-07-58-21.png)


