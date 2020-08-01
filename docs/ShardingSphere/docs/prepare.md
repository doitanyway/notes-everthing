# 测试shardingsphere的准备工作


本文主要讲解测试sharding sphere测试的一些准备工作，为测试sharding sphere，我们需要准备mysql 或者是pg sql数据库，测试建议使用docker 运行，本文讲解如何运行对应的容器，为执行相关的测试做一些准备。




## docker 容器 

```bash 
docker run --name some-mysql  \
   -v $PWD/datadir:/var/lib/mysql \
    -e MYSQL_ROOT_PASSWORD=123456 -p 3307:3306 -d mysql:5.7
    
```