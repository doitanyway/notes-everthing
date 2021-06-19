



## 字段类型

* 核心数据类型
  * 字符串： text,keyword(不分词，智能使用完整词搜索）
  * 数值型：long,integer,short,byte,double,float,half_float,scaled_float
  * 布尔类型：boolean
  * 二进制： binary(二进制经过base64编码之后的字符串，不可搜索)
  * 范围类型：integer_range,float_range,long_range,double_range,date_rage
  * 日期: date
* 复杂数据类型
  * 数组，Array: es并无专门的数组类型，可以在插入文档的时候直接声明一个数组插入即可,(``[1,2]-整形数组``,``[”1“,”2“]-字符串数组``,``[{"name":"nick"},{"name": "elaine"}]``)
  * 对象，Object:
* 专用数据类型，如IP;

> 官方文档：https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping-types.html


## 举例 


```bash 
# 创建学生索引，age_range代表读书的年级
curl -X PUT 'localhost:9200/student' -H "Content-Type: application/json" -d '
{
  "mappings":{
    "properties": {
      "name": {
        "type": "text" 
      },
      "age_range": {
        "type": "integer_range" 
      }
    }
  }
}
'
# age_range 大于0 小于200
curl -X PUT 'localhost:9200/student/_doc/1' -H "Content-Type: application/json" -d '
{
  "name": "张三",
  "age_range": {
    "gte": 5,
    "lte": 25
  }
}
'

# 搜索20岁还在读书的人
curl -X POST 'localhost:9200/student/_search' -H "Content-Type: application/json" -d '
{
  "query":{
    "term": {
      "age_range": 20
    }
  }
}
'

# 添加数组类型
curl -X PUT 'localhost:9200/student/_doc/2' -H "Content-Type: application/json" -d '
{
  "name": "张三",
  "age_range": {
    "gte": 5,
    "lte": 25
  },
  "array1": [1,2,3]
}
'

# 添加对象类型
curl -X PUT 'localhost:9200/student/_doc/3' -H "Content-Type: application/json" -d '
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

# 根据对象的类容搜索
curl -X POST 'localhost:9200/student/_search' -H "Content-Type: application/json" -d '
{
  "query":{
    "match": {
      "address.location.city": "深圳"
    }
  }
}
'

```