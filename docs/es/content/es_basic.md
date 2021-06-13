# es基本操作

## 简介

es的基本操作是restfull风格的，我们可以通过get/post/delete/put等操作与es交互，本节简单的介绍如何一些基本的操作命令


## 基本操作

* 获取es状态 

```bash 
nick@nicks-MacBook-Pro  ~/Desktop/software/es/elasticsearch-7.13.1  curl -X GET "http://localhost:9200"
{
  "name" : "nicks-MacBook-Pro.local",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "p17icuWURHastv80WGtpFg",
  "version" : {
    "number" : "7.13.1",
    "build_flavor" : "default",
    "build_type" : "tar",
    "build_hash" : "9a7758028e4ea59bcab41c12004603c5a7dd84a9",
    "build_date" : "2021-05-28T17:40:59.346932922Z",
    "build_snapshot" : false,
    "lucene_version" : "8.8.2",
    "minimum_wire_compatibility_version" : "6.8.0",
    "minimum_index_compatibility_version" : "6.0.0-beta1"
  },
  "tagline" : "You Know, for Search"
}
```

* 新增一个文档

```bash
# 应答如下
curl -X PUT "localhost:9200/student/_doc/1" -H 'Content-type: application/json' -d'
{
  "name": "Nick",
  "age": "30"
}
'
# 应答如下
{"_index":"student","_type":"_doc","_id":"1","_version":1,"result":"created","_shards":{"total":2,"successful":1,"failed":0},"_seq_no":0,"_primary_term":1}
```

* 查询这个文档 

```bash 
# 查询指定文档
curl -X GET "localhost:9200/student/_doc/1"

# 查询index（索引）下所有文档
curl -X GET "localhost:9200/student"
```

* 删除文档

```bash 
curl -X DELETE "localhost:9200/student/_doc/1"
```