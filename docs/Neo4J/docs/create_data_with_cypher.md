# 使用cypher创建和查询数据



## 简介

cypher 是neo4j的查询语言，最长用的命令如下

```bash 
MATCH      查询数据
CREATE     创建数据
MERGE      合并数据
```

查询相关内容的基本概念

* 节点：图数据库的基本元素用来表示一个实体记录，在neo4j中一个节点可以包含多个label和property
* 关系：图数据库中的基本元素，当数据库中已经存在节点之后使用关系将节点连接起来，关系可以包含多个属性，但是只能有一个type，且2个节点之间可以有多个关系，关系有方向性，且可以指向自己
* 属性：节点和关系都可以有自己的属性
* 路径：使用节点和关系创建一个图之后，图中任意2个节点都可能存在节点和关系的路径，其中路径可能有多条和长短
* 遍历：按一定规则，根据他们之间的关系依次访问相关节点的操作



## CREATE 

* 创建一个节点``CREATE (n)``  


![](./assets/2021-03-20-16-50-34.png)


* 创建多个节点``CREATE (n),(m)``

![](./assets/2021-03-20-16-52-35.png)

* 创建节点并且添加一个标签``CREATE (n:Person)``

* 创建节点并且添加多个标签``CREATE (n:Person:Swedish)``

* 创建节点，添加标签，并且可以同时给该节点添加属性``CREATE (n:Person {name: 'Andy', title: 'Developer'})``

* 创建一个节点，并且查询相关的值  

```bash 
CREATE (a {name: 'Andy'})
RETURN a.name
```

![](./assets/2021-03-20-16-59-23.png)



* 两个node 之间创建关系 

```bash 
# 1.创建第一个节点
CREATE (n:Person {name: 'A', title: 'Developer'})
# 2.创建第二个节点
CREATE (n:Person {name: 'B', title: 'Developer'})

MATCH
  (a:Person),
  (b:Person)
WHERE a.name = 'A' AND b.name = 'B'
CREATE (a)-[r:RELTYPE]->(b)
RETURN type(r)
```

## match 

*  ``match (a) return a ``查询所有节点
*  ``match (n) return (n) limit 10`` 查询所有节点，并且限制结果最多10个
*  ``match (a:Person) return a ``,查询所有包含``Person``的标签


## merge 



## 删除所有数据

```bash 
match (a:Person),(m:Movie) optional match (a)-[r1]-(),(m)-[r2]-() delete a,m,r1,r2  
```