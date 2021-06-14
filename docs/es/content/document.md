
# 文档的基本操作

## 简介

本文主要讲解并演示如何新增、删除、修改、查询文档，以及如何配置自动创建文档。

## 新增文档


```bash 
# 创建索引
curl -X PUT "http://localhost:9200/student"
# 创建mapping
curl -X PUT "localhost:9200/student/_mapping" -H 'Content-Type: application/json' -d'
{
  "properties": {
    "name": {
      "type": "text"
    },
    "years":{
      "type": "integer"
    }
  }
}
'

# 指定ID新增文档
curl -X PUT "localhost:9200/student/_doc/1" -H "Content-Type: application/json" -d'
{
  "name": "Nick",
  "age": 19
}
'

# 不指定ID新增文档
curl -X POST "localhost:9200/student/_doc" -H "Content-Type: application/json" -d'
{
  "name": "Nick",
  "age": 19
}
'


```


## 指定操作类型 


```bash 
# 创建文档，如果该文档已经存在则会UPDATE
curl -X PUT "localhost:9200/student/_doc/1" -H "Content-Type: application/json" -d'
{
  "name": "Nick",
  "age": 35
}
'

# 指定创建操作，如果该文档已经存在则会报错，该操作可以避免错误
curl -X PUT "localhost:9200/student/_doc/1?op_type=create" -H "Content-Type: application/json" -d'
{
  "name": "Nick",
  "age": 35
}
'
```


## 查看文档

```bash 
# 通过ID查看文档
curl -X GET "localhost:9200/student/_doc/1"


curl -X POST "localhost:9200/_mget?pretty" -H "Content-Type: application/json" -d '
{
  "docs":[
    {
      "_index": "student",
      "_type": "_doc",
      "_id": "1"
    },
    {
      "_index": "school",
      "_type": "_doc",
      "_id": "1"
    }
  ]
}
'

# 指定索引，然后获取多个ID值的文档
curl -X POST "localhost:9200/student/_mget?pretty" -H "Content-Type: application/json" -d '
{
  "docs":[
    {
      "_type": "_doc",
      "_id": "1"
    },
    {
      "_type": "_doc",
      "_id": "2"
    }
  ]
}
'

# 指定索引，文档，然后获取多个ID值的文档
curl -X POST "localhost:9200/student/_doc/_mget?pretty" -H "Content-Type: application/json" -d '
{
  "docs":[
    {
      "_id": "1"
    },
    {
      "_id": "2"
    }
  ]
}
'


curl -X POST "localhost:9200/student/_doc/_mget?pretty" -H "Content-Type: application/json" -d '
{
  "ids": [1,2]
}
'


```


## 修改文档


```bash 
# 指定id修改
curl -X POST "localhost:9200/student/_update/1" -H "Content-Type: application/json" -d '
{
  "doc": {
    "name": "Elaine"
  }
}
'
curl -X GET "localhost:9200/student/_doc/1?pretty"

# 新增字段,ctx上下文
curl -X POST "localhost:9200/student/_update/1" -H "Content-Type: application/json" -d '
{
  "script": "ctx._source.age1 = 19"
}
'

# 删除字段,ctx上下文
curl -X POST "localhost:9200/student/_update/1" -H "Content-Type: application/json" -d '
{
  "script": "ctx._source.remove(\"age1\")"
}
'

# 更新, upsert当文档不存在时,upsert内的内容将会插入到索引中，作为一个新文档
curl -X POST "localhost:9200/student/_update/1" -H "Content-Type: application/json" -d '
{
  "script": {
    "source":  "ctx._source.age += params.age",
    "params": {
      "age": 4
    }
  },
  "upsert":{
    "age": 1
  }
}
'

```


## 删除

```bash 
# 删除指定文档
curl -X DELETE "localhost:9200/student/_doc/1" -H "Content-Type: application/json" 

```

## 自动创建索引

* 当索引不存在，并且auto_create_index为true的时，新增文档会自动创建索引
```bash 
# 查看方法
curl http://localhost:9200/_cluster/settings
# 配置方法
curl -X PUT "localhost:9200/_cluster/settings" -H "Content-Type: application/json" -d'
{
  "persistent": {
    "action.auto_create_index": "true"
  }
}
'

```
