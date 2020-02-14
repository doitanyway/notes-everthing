# 导入CSV文件到Neo4j


## 准备文件 

```bash 
cat <<EOF>> demo/actors.csv
personId:ID,name,:LABEL
keanu,"Keanu Reeves",Actor
laurence,"Laurence Fishburne",Actor
carrieanne,"Carrie-Anne Moss",Actor
EOF

cat <<EOF>> demo/movies.csv
movieId:ID,title,year:int,:LABEL
tt0133093,"The Matrix",1999,Movie
tt0234215,"The Matrix Reloaded",2003,Movie;Sequel
tt0242653,"The Matrix Revolutions",2003,Movie;Sequel
EOF

cat <<EOF>> demo/roles.csv
:START_ID,role,:END_ID,:TYPE
keanu,"Neo",tt0133093,ACTED_IN
keanu,"Neo",tt0234215,ACTED_IN
keanu,"Neo",tt0242653,ACTED_IN
laurence,"Morpheus",tt0133093,ACTED_IN
laurence,"Morpheus",tt0234215,ACTED_IN
laurence,"Morpheus",tt0242653,ACTED_IN
carrieanne,"Trinity",tt0133093,ACTED_IN
carrieanne,"Trinity",tt0234215,ACTED_IN
carrieanne,"Trinity",tt0242653,ACTED_IN
EOF
````


> :LABEL 代表这个实体打的标签，使用“;”隔开
> movieId:ID和personId:ID是主键，主键ID库内不重复
> :START_ID 关系开始
> :END_ID 关系结束
> :TYPE 关系类型



* 导入数据 

```bash 
neo4j-admin import --id-type=STRING \
      --nodes=demo/movies.csv --nodes=demo/actors.csv --relationships=demo/roles.csv
```
