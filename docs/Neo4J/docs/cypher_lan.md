# cypher基础-cypher语句


## 简介 

cypher语句主要包含如下类型；

* 读语句，MATCH,OPTIONAL MATCH,WHERE,START,Aggregation和LOAD CSV
* 写语句，CREATE,MERGE,SET,DELET,REMOVE,FOREACH,CREATE UNIQUE
* 通用语句，RETURN,ORDER BY,LIMIT,SKIP,WITH,UNWIND,UNION,CALL



> 因为内容多，本文只记录一些关键信息，更多信息请查看[官方文档](https://neo4j.com/docs/cypher-manual/4.2/clauses/)

## 详细介绍

### MATCH 

模式检验数据库

* 基础查询

```bash 
# 简单查询
MATCH (n)
RETURN n
# 查询带某类节点
MATCH (movie:Movie)
RETURN movie.title
# 查询相关的节点  
MATCH (director {name: 'Oliver Stone'})--(movie)
RETURN movie.title
# 使用label和属性一起查找
MATCH (:Person {name: 'Oliver Stone'})--(movie:Movie)
RETURN movie.title
```

* 关系查询  

```bash 
# 找到有关系的2个节点
MATCH (:Person {name: 'Oliver Stone'})-->(movie)
RETURN movie.title
# 查看关系 
MATCH (:Person {name: 'Oliver Stone'})-[r]->(movie)
RETURN type(r)
# 指明关系
MATCH (wallstreet:Movie {title: 'Wall Street'})<-[:ACTED_IN]-(actor)
RETURN actor.name
# 匹配多种关系的节点
MATCH (wallstreet {title: 'Wall Street'})<-[:ACTED_IN|:DIRECTED]-(person)
RETURN person.name
# 使用变量来匹配关系
MATCH (wallstreet {title: 'Wall Street'})<-[r:ACTED_IN]-(actor)
RETURN r.role
```

* 关系深度查询 

```bash 
# 在Person {name: 'Charlie Sheen'} 节点和Person {name: 'Rob Reiner'}节点上创建一个关系
MATCH
  (charlie:Person {name: 'Charlie Sheen'}),
  (rob:Person {name: 'Rob Reiner'})
CREATE (rob)-[:`TYPE INCLUDING A SPACE`]->(charlie)

MATCH (n {name: 'Rob Reiner'})-[r:`TYPE INCLUDING A SPACE`]->()
RETURN type(r)
```


* 多关系的查询 

```bash 
MATCH (charlie {name: 'Charlie Sheen'})-[:ACTED_IN]->(movie)<-[:DIRECTED]-(director)
RETURN movie.title, director.name
```

* 关系层级 
```bash 
MATCH (charlie {name: 'Charlie Sheen'})-[:ACTED_IN*1..3]-(movie:Movie)
RETURN movie.title
```

* 关系层级使用多种类型 

```bash 
MATCH (charlie {name: 'Charlie Sheen'})-[:ACTED_IN|DIRECTED*2]-(person:Person)
RETURN person.name
```


* 统计次数,采购人名称，供应商名称，以及该采购人和该供应商达成交易次数，只返回其中次数最大的三个，且降序排列返回

```bash 
match 
	(p:Purchaser) --()<-[:WBID] - (s:Supplier) return p.name ,s.name,count(*) as times  ORDER BY times DESC SKIP 0  LIMIT 3
```



### OPTIONAL MATCH
### WHERE

### START
### Aggregation
### LOAD CSV
### CREATE

### MERGE
### SET
### DELET
### REMOVE
### FOREACH 
### CREATE UNIQUE

### RETURN
### ORDER BY
### LIMIT
### SKIP
### WITH
### UNWIND
### UNION
### CALL