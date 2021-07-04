# es的多种基本查询方法

es有如下常用的查询方法

* term 精确查询，某个字段必须完全等于查询结果
* exists 是否存在查询
* prefix 前缀查询
* wildcard 查询：通配符查询，* 代表任意多个字符，？代表一个字符
* regexp 正则表达式查询
* ids  通过id批量查询
* range 范围查询
* bool 布尔查询
  * must 必须出现在匹配⽂档中
  * filter 必须出现在匹配文档中，不打分
  * must_not 不能出现在⽂档中
  * should 应该出现在⽂档中






## 详细介绍 


###  term 

精确查询，某个字段必须完全等于查询结果

```bash 
# 查找name为Nick的记录
POST student/_search
{
  "query": {
    "term": {
      "name": "Nick"
    }
  }
}
```



###  exists 

是否存在查询,在索引中找出所有指定field为不为空的文档 

```bash 
# 在索引中找出所有指定field name为不为空的文档 
POST student/_search
{
  "query": {
    "exists": {
      "field": "name"
    }
  }
}
```



###  prefix

前缀查询,搜索某列包含指定前缀的文档 

```bash 
# 查询名字前缀是Ni的学生
POST student/_search
{
  "query": {
    "prefix": {
      "name": "Ni"
    }
  }
}
```



### wildcard 

查询：通配符查询，* 代表任意多个字符，？代表一个字符

```bash 
# 查询名字开始是Ni,结束是k的学生
POST student/_search
{
"query": {
  "wildcard": {
    "name": "Ni*k"
    }
  }
}
```

### regexp 正则表达式查询

```bash 
# 查询名字开始是Ni,结束是k的学生
POST student/_search
{
  "query": {
    "regexp": {
    "name": "Ni.*k"
    }
  }
}
```



### ids  

通过id批量查询id为某些值的文档 

```bash 
POST student/_search
{
  "query": {
    "ids": {
      "values": [1,2]
    }
  }
}
```


### 范围查询

* 数据准备

```bash 

POST /_bulk
{"index": {"_index": "student","_id":1} }
{"name":"Nick","age":12,"birthDay": "2009-12-02"}
{"index": {"_index": "student","_id":2} }
{"name":"李明","age":22,"birthDay": "1999-12-02"}
{"index": {"_index": "student","_id":3} }
{"name":"李少年","age":25,"birthDay": "1996-12-02"}
{"index": {"_index": "student","_id":4} }
{"name":"elaine","age":30,"birthDay": "1991-01-02"}

```

* 查询年龄范围在[2,22]范围内

```bash 
POST student/_search
{
  "query": {
    "range": {
      "age": {
        "gte": 2,
        "lte": 22
       }
     }
   }
}

# 返回结果
{
  "took" : 1,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 2,
      "relation" : "eq"
    },
    "max_score" : 1.0,
    "hits" : [
      {
        "_index" : "student",
        "_type" : "_doc",
        "_id" : "1",
        "_score" : 1.0,
        "_source" : {
          "name" : "Nick",
          "age" : 12
        }
      },
      {
        "_index" : "student",
        "_type" : "_doc",
        "_id" : "2",
        "_score" : 1.0,
        "_source" : {
          "name" : "李明",
          "age" : 22
        }
      }
    ]
  }
}

```

* 使用时间查询  

```bash 

POST student/_search
{
  "query": {
    "range": {
      "birthDay": {
        "gte": "1991-12-01",
        "lte": "2008",
        "format": "yyyy-MM-dd||yyyy"
       }
     }
   }
}
# 返回值
{
  "took" : 1,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 1,
      "relation" : "eq"
    },
    "max_score" : 1.0,
    "hits" : [
      {
        "_index" : "student",
        "_type" : "_doc",
        "_id" : "2",
        "_score" : 1.0,
        "_source" : {
          "name" : "李明",
          "age" : 22,
          "birthDay" : "1999-12-02"
        }
      }
    ]
  }
}

```



* must 查询，必须匹配，要打分

```bash 
POST /student/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "match": {
            "name": "李"
          }
        }
      ]
    }
  }
}
```


*  must 查询，必须匹配，不打分 等价于and

```bash 
POST /student/_search
{
  "query": {
    "bool": {
      "filter": [
        {
          "match": {
            "name": "李"
          }
        }
      ]
    }
  }
}
```

*  must_not 不能出现在⽂档中

```bash 
POST /student/_search
{
  "query": {
    "bool": {
      "must_not": [
        {
          "match": {
            "name": "李"
          }
        }
      ]
    }
  }
}

```

*  should 是 or 的意思，但是如果你只有一个 should 条件那就类似于 must 

```bash 
POST /student/_search
{
  "query": {
    "bool": {
      "should": [
        {
          "match": {
            "name": "李"
          }
        }
      ]
    }
  }
}
```

*  must和should 混用   姓名含李 and 年龄 22

```bash 
POST /student/_search
{
  "query": {
    "bool": {
      "must": [
        {"match": {"name": "李"}},
        {
          "bool": {
            "should": [
               {"match": { "age": "22"}}
            ]
          }
        }
      ]
    }
  }
}
```

*  must和should 混用   姓名含李 and 姓名含明

```bash 
POST /student/_search
{
  "query": {
    "bool": {
      "must": [
        {"match": {"name": "李"}},
        {"match": {"name": "明"}}
      ]
    }
  }
}
```

*    姓名含李 or  姓名含elaine

```bash 
POST /student/_search
{
  "query": {
    "bool": {
      "should": [
        {"match": {"name": "李"}},
        {"match": { "name": "elaine"}}
      ]
    }
  }
}
```