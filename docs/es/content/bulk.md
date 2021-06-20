

# bulk API 


bulk API 用来批量操作数据，可以用来批量创建、批量全部更新、局部批量更新、批量删除操作。

## 批量创建数据

* 直接使用post api 

```bash 
# 第一个数据
POST /_bulk
{"index": {"_index": "student","_id":1} }
{"name":"Nick"}
{"index": {"_index": "student","_id":2} }
{"name":"李明"}

```

* 使用文件 

```bash

cat << 'EOF' > students
{"index": {"_index": "student","_id":1} }
{"name":"Nick"}
{"index": {"_index": "student","_id":2} }
{"name":"李明"}

EOF

# 批量导入，students是文件的名称
curl -X POST "http://elastic:DeXac7bdHt45OGSyTtsQ@localhost:9200/_bulk?pretty" -H "Content-Type: application/json" --data-binary @students

```

## 批量删除数据

```bash 
curl -X POST  "localhost:9200/_bulk"  -H "Content-Type: application/json"  -d '
{"delete":{"_index":"student","_id":"12"}}
{"delete":{"_index":"student","_id":"13"}}
‘

```

## 批量更新

* 全部更新，和创建类似,如下：
```bash 
curl -X POST  "localhost:9200/_bulk"  -H "Content-Type: application/json"  -d '
 {"index":{"_index":"student","_id":"1"}}
 {"name":"邱家洪"}
'
```

* 部分更新,指定update操作，数据外层使用doc关键字
```bash 
curl -X POST  "localhost:9200/_bulk"  -H "Content-Type: application/json"  -d '
{"update":{"_index":"student","_id":"1"}}
{"doc":{"name":"Nick Qiu"}}
'
```

