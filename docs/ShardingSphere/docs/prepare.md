# 测试shardingsphere的准备工作


本文主要讲解测试sharding sphere测试的一些准备工作，为测试sharding sphere，我们需要准备mysql 或者是pg sql数据库，测试建议使用docker 运行，本文讲解如何运行对应的容器，为执行相关的测试做一些准备。




## docker 容器 

```bash 
# 要持久化数据
docker run --name some-mysql  \
   -v $PWD/datadir:/var/lib/mysql \
    -e MYSQL_ROOT_PASSWORD=123456 -p 3307:3306 -d mysql:5.7

#  不持久化数据
docker run --name some-mysql  \
    -e MYSQL_ROOT_PASSWORD=123456 -p 3307:3306 -d mysql:5.7


```

> 参考：  https://hub.docker.com/_/mysql


## pg sql 容器(pstgres sql)


```bash 
# 要持久化数据
docker run -d \
    --name some-postgres \
    -e POSTGRES_PASSWORD=mysecretpassword \
    -e PGDATA=/var/lib/postgresql/data/pgdata \
    -v /custom/mount:/var/lib/postgresql/data \
    postgres:9.6.18

#  不持久化数据
docker run --name some-postgres \
  -e POSTGRES_PASSWORD=mysecretpassword -d postgres:9.6.18
  
````


> 参考:  https://hub.docker.com/_/postgres


