# mac安装es

## 简介

本文讲解如何在mac内安装es，并且配置密码增强es的安全性

## 安装步骤 

```bash 
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.13.1-darwin-x86_64.tar.gz
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.13.1-darwin-x86_64.tar.gz.sha512
shasum -a 512 -c elasticsearch-7.13.1-darwin-x86_64.tar.gz.sha512 
tar -xzf elasticsearch-7.13.1-darwin-x86_64.tar.gz
# 该路径是变量$ES_HOME的路径
cd elasticsearch-7.13.1/ 

#  启动es 
./bin/elasticsearch
#  后台启动es，记录进程的pid到文件pid内
./bin/elasticsearch -d -p pid


# 验证es是否正常安装,如下命令返回集群的信息 
curl localhost:9200
## 返回信息如下：
{
  "name" : "Cp8oag6",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "AT69_T_DTp-1qgIJlatQqA",
  "version" : {
    "number" : "7.13.1",
    "build_flavor" : "default",
    "build_type" : "tar",
    "build_hash" : "f27399d",
    "build_date" : "2016-03-30T09:51:41.449Z",
    "build_snapshot" : false,
    "lucene_version" : "8.8.2",
    "minimum_wire_compatibility_version" : "1.2.3",
    "minimum_index_compatibility_version" : "1.2.3"
  },
  "tagline" : "You Know, for Search"
}

# 关闭es 
pkill -F pid


```



## 配置密码

* 关闭es和kibana

* 进入es的安装目录，修改配置文件``vim ES_PATH_CONF/elasticsearch.yml``

```bash 
# 使能xpack的基本安全功能 
xpack.security.enabled: true

# option 如果集群只有一个节点，则添加入下配置
# discovery.type: single-node


```

* 为默认用户配置密码

```bash 
# 进入es目录，重新启动ES 
./bin/elasticsearch

# ES中内置了几个管理账号即：apm_system, beats_system, elastic, kibana, logstash_system, remote_monitoring_user，使用之前，首先需要添加一下密码。新打开一个窗口，执行如下命令配置密码``cd ES_INSTALL_PATH``，如下选择一个方式配置密码
./bin/elasticsearch-setup-passwords auto    # 自动生成密码

Changed password for user apm_system
PASSWORD apm_system = RIuNWv5xEVGGc0CqLKGZ

Changed password for user kibana_system
PASSWORD kibana_system = mOe4zLy838VfMSKZK4kn

Changed password for user kibana
PASSWORD kibana = mOe4zLy838VfMSKZK4kn

Changed password for user logstash_system
PASSWORD logstash_system = Q2tpES4Mh72hArtOZRuO

Changed password for user beats_system
PASSWORD beats_system = 3cByriDjcz5ziIH0roxt

Changed password for user remote_monitoring_user
PASSWORD remote_monitoring_user = zSY1JnyHYZQhWLosRbZ6

Changed password for user elastic
PASSWORD elastic = DeXac7bdHt45OGSyTtsQ


./bin/elasticsearch-setup-passwords interactive     # 用户交互输入密码

```


* 配置kibana,进入kibana目录,修改配置文件``KIB_PATH_CONF/kibana.yml``,去掉如下行的注释

```bash 
elasticsearch.username: "kibana_system"
```

* 创建 Kibana keystore

```bash 
./bin/kibana-keystore create
```

* 添加密码到keystore文件

```bash 
# 输入该命令之后再输入``kibana_system``的密码
./bin/kibana-keystore add elasticsearch.password
```

* 重新启动kibana

```bash 
./bin/kibana
```

* 使用``elastic``用户访问kibana,使用该用户[管理空间、创建用户、分配角色](https://www.elastic.co/guide/en/kibana/7.13/tutorial-secure-access-to-kibana.html)，如果kibana本地启动则使用URL：``http://localhost:5601/``
  


* 使用用户名密码查询数据

```bash 
# 添加对象类型
curl -X PUT 'http://elastic:DeXac7bdHt45OGSyTtsQ@localhost:9200/student/_doc/3' -H "Content-Type: application/json" -d '
{
  "name": "张三",
  "age_range": {
    "gte": 5,
    "lte": 25
  },
  "address": {
    "contry": "China",
    "location": {
      "province": "广东",
      "city": "深圳"
    }
  }
}
'

# 查询数据
curl -X POST 'http://elastic:DeXac7bdHt45OGSyTtsQ@localhost:9200/student/_search' -H "Content-Type: application/json" -d '
{
  "query":{
    "match": {
      "address.location.city": "深圳"
    }
  }
}
'

# 查询数据
curl -X GET "http://elastic:DeXac7bdHt45OGSyTtsQ@localhost:9200/student/_doc/3?pretty"
```
