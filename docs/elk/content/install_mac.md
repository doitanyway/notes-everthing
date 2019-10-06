
# mac安装elasticsearch

## 前言

本文讲解如何在MAC上安装elasticserach
* Kibana 7.4.0
* elasticsearch-7.4.0

## 操作步骤

```bash
# 下载软件
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.4.0-darwin-x86_64.tar.gz
wget https://artifacts.elastic.co/downloads/kibana/kibana-7.4.0-darwin-x86_64.tar.gz
# 解压软件 
tar -xzvf elasticsearch-7.4.0-darwin-x86_64.tar.gz
tar -xzvf kibana-7.4.0-darwin-x86_64.tar.gz
## 启动es，检查日志输出没有错误
cd elasticsearch-7.4.0
./bin/elasticsearch
# 启动Kibana，检查日志输出没有错误
cd ../kibana-7.4.0-darwin-x86_64/
./bin/kibana
# 启动
```

## 检验 

* Kanana启动成功之后有如下日志打印:  

```logs
  log   [06:54:18.596] [info][listening] Server running at http://localhost:5601
  log   [06:54:18.608] [info][server][Kibana][http] http server running at http://localhost:5601
  log   [06:54:19.362] [info][status][plugin:spaces@7.4.0] Status changed from yellow to green - Ready
```

* 网页访问服务器  http://localhost:5601

* 点击dev tools ![](./assets/2019-10-06-15-05-31.png)

* 在console 标签上依次执行如下两条命令：  
```JSON
// 写数据
PUT index/type/1
{
  "body":"here"
}
// 读数据
GET index/type/1
```
