# es的多种基本查询方法

es有如下常用的查询方法

* term 精确查询，某个字段必须完全等于查询结果
* exists 是否存在查询
* prefix 前缀查询
* wildcard 查询：通配符查询，* 代表任意多个字符，？代表一个字符
* regexp 正则表达式查询
* ids  通过id批量查询


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

