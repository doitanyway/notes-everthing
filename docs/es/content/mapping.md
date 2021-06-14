
# es的mapping 


## 概念

mapping用来定义索引的结构

## 基本操作

* 新增mapping 

```bash 
# 新建索引
curl -X PUT "http://localhost:9200/school"
# 获得索引信息，发现是一个空的索引
curl -X GET "http://localhost:9200/school?pretty"
# 手动创建mapping
curl -X PUT "localhost:9200/school/_mapping" -H 'Content-Type: application/json' -d'
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

# 获取mapping
curl -X GET "localhost:9200/school/_mapping"
# 获取多个索引的mapping
curl -X GET "localhost:9200/school,student/_mapping"

# 给mapping添加内容 
curl -X POST "localhost:9200/school/_mapping" -H 'Content-Type: application/json' -d'
{
  "properties": {
    "name": {
      "type": "text"
    },
    "years":{
      "type": "integer"
    },
    "address":{
      "type": "text"
    }
  }
}
'


```

> mapp字段的类型不能直接修改，如果需要修改则需要重建索引。
> mapping支持的基本类型： 
>  * 数指型：long、integer、short、byte、double、float
>  * 日期型：date
>  * 布尔型：boolean
>  * 二进制型：binary
> mapping支持的复杂类型 
>  * 数组类型（Array datatype），数组类型不需要专门指定数组元素的type，如： ["str","str1"] 、[1,2]、[{"name": "Nick"},{"name": "Jone"}]
> 更多类型参考： https://blog.csdn.net/zx711166/article/details/81667862