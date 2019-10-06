
# mac安装elasticsearch

## 前言

本文讲解如何在MAC上安装elasticserach
* Kibana 7.4.0
* elasticsearch-7.4.0

## 操作步骤

```bash
# 下载软件
## linux
# curl -L -O https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.4.0-linux-x86_64.tar.gz
## mac
curl -L -O https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.4.0-darwin-x86_64.tar.gz

wget https://artifacts.elastic.co/downloads/kibana/kibana-7.4.0-darwin-x86_64.tar.gz
# 解压软件 
tar -xzvf elasticsearch-7.4.0-darwin-x86_64.tar.gz
tar -xzvf kibana-7.4.0-darwin-x86_64.tar.gz
## 启动es，检查日志输出没有错误
cd elasticsearch-7.4.0
./bin/elasticsearch
# 后台启动
# ./bin/elasticsearch -d  
# 启动Kibana，检查日志输出没有错误
cd ../kibana-7.4.0-darwin-x86_64/
./bin/kibana
# 后台启动
# nohup ../bin/kibana &
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


## 补充说明

* 启动2个es实例，必须在启动的时候指定一些特别的唯一变量
```
./elasticsearch -Epath.data=data2 -Epath.logs=log2
./elasticsearch -Epath.data=data3 -Epath.logs=log3
```

* es的健康检查 

```BASH 
 nick@nicks-MacBook-Pro  ~  curl -X GET "localhost:9200/_cat/health?v&pretty"

epoch      timestamp cluster       status node.total node.data shards pri relo init unassign pending_tasks max_task_wait_time active_shards_percent
1570347393 07:36:33  elasticsearch yellow          1         1      5   5    0    0        1             0                  -                 83.3%
```

> green 状态良好，es有多个实例存储数据
> yellow 状态正常，但是数据只有一个实例
> red   状态异常，有数据不能访问


* 关闭kinaba 

```bash
[root@node1 ~]# ps -ef | grep node
elastic    2192   2160  2 06:15 pts/1    00:00:44 bin/../node/bin/node --no-warnings bin/../src/cli
root       2256   2235  0 06:51 pts/2    00:00:00 grep --color=auto node
[root@node1 ~]# kill 2192
```