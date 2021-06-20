
# 搜索命令

## 简介

本文讲解es常用的搜索命令，在es中，可以精确搜索（词条查询），也可以匹配全文搜索（全文查询），区别如下：


* 词条(term)查询，不会分析查询的条件，只有当词条和查询字符串完全匹配时，才匹配搜索；
* 全文查询(full text)： es先分析字符串，把字符串拆成多个分词，只要已经分析的字段中包含词条的任意一个，或者全部包含就匹配查询条件，返回该文档；



## 数据准备

```bash 
# 新增index
curl -X PUT localhost:9200/student -H "Content-type: application/json" -d '
{
  "mappings": {
    "properties":{
      "name": {
        "type": "text"
      },
      "home": {
        "type": "text"
      },
      "hobby": {
        "type": "text"
      },
      "age":{
        "type": "long"
      },
      "grade": {
        "type": "keyword"
      }
    }
  }
}
'


# 大一
curl -X PUT localhost:9200/student/_doc/1 -H "Content-type: application/json" -d '
{
  "name": "张三",
  "home": "深圳",
  "hobby": "篮球、足球",
  "age": 23,
  "grade": "大一"
}
'

curl -X PUT localhost:9200/student/_doc/2 -H "Content-type: application/json" -d '
{
  "name": "张四",
  "home": "深圳",
  "hobby": "篮球、乒乓",
  "age": 22,
  "grade": "大一"
}
'


curl -X PUT localhost:9200/student/_doc/3 -H "Content-type: application/json" -d '
{
  "name": "张五",
  "home": "重庆",
  "hobby": "游泳、乒乓",
  "age": 26,
  "grade": "大一"
}
'

# 大二
curl -X PUT localhost:9200/student/_doc/4 -H "Content-type: application/json" -d '
{
  "name": "王三",
  "home": "深圳",
  "hobby": "篮球、足球",
  "age": 23,
  "grade": "大二"
}
'

curl -X PUT localhost:9200/student/_doc/5 -H "Content-type: application/json" -d '
{
  "name": "王四",
  "home": "深圳",
  "hobby": "游泳、乒乓",
  "age": 22,
  "grade": "大二"
}
'


curl -X PUT localhost:9200/student/_doc/6 -H "Content-type: application/json" -d '
{
  "name": "王五",
  "home": "重庆",
  "hobby": "乒乓",
  "age": 26,
  "grade": "大二"
}
'


```


## 查询

* 单条term 

```bash 
# 查询所有大二的记录
curl -X POST localhost:9200/student/_search -H "Content-Type: application/json" -d '
{
  "query":{
    "term":{
      "grade": "大二"
    }
  }
}
'
# 应答如下：
{"took":4,"timed_out":false,"_shards":{"total":1,"successful":1,"skipped":0,"failed":0},"hits":{"total":{"value":3,"relation":"eq"},"max_score":1.0498221,"hits":[{"_index":"student","_type":"_doc","_id":"4","_score":1.0498221,"_source":
{
  "name": "王三",
  "home": "深圳",
  "hobby": "篮球、足球",
  "age": 23,
  "grade": "大二"
}
},{"_index":"student","_type":"_doc","_id":"5","_score":1.0498221,"_source":
{
  "name": "王四",
  "home": "深圳",
  "hobby": "游泳、乒乓",
  "age": 22,
  "grade": "大二"
}
},{"_index":"student","_type":"_doc","_id":"6","_score":1.0498221,"_source":
{
  "name": "王五",
  "home": "重庆",
  "hobby": "乒乓",
  "age": 26,
  "grade": "大二"
}
}]}}%



# 查询所有22岁和23岁的人
curl -X POST localhost:9200/student/_search -H "Content-Type: application/json" -d '
{
  "query":{
    "terms":{
      "age": [
        22,23
      ]
    }
  }
}
'


# 显示所有记录，默认显示前10条
curl -X POST localhost:9200/student/_search -H "Content-Type: application/json" -d '
{
  "query":{
    "match_all":{}
  }
}
'


# 分页查询记录，从0页开始，显示3条记录
curl -X POST localhost:9200/student/_search -H "Content-Type: application/json" -d '
{
  "query":{
    "match_all":{}
  },
  "from": 0,
  "size": 3
}
'

# 全文搜索，搜索字段必须是text
curl -X POST localhost:9200/student/_search -H "Content-Type: application/json" -d '
{
  "query":{
    "match":{
      "hobby": "篮球"
    }
  },
  "from": 0,
  "size": 3
}
'


# 多条件查询,从多个fileds内查询关键字
curl -X POST localhost:9200/student/_search -H "Content-Type: application/json" -d '
{
  "query":{
    "multi_match":{
      "query": "篮球",
      "fields": ["hobby","home"]
    }
  },
  "from": 0,
  "size": 3
}
'



# 准确查询，查询必须包含【篮球、乒乓】
curl -X POST localhost:9200/student/_search -H "Content-Type: application/json" -d '
{
  "query":{
    "match_phrase":{
      "hobby": "篮球、乒乓"
    }
  },
  "from": 0,
  "size": 3
}
'



```
