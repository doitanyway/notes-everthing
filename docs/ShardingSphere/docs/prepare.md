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
    -e POSTGRES_PASSWORD=123456 \
    -e PGDATA=/var/lib/postgresql/data/pgdata \
    -v /custom/mount:/var/lib/postgresql/data \
   -p 5432:5432  \
    postgres:9.6.18

#  不持久化数据
docker run --name some-postgres \
   -p 5432:5432  \
  -e POSTGRES_PASSWORD=123456 -d postgres:9.6.18

````


> 参考:  https://hub.docker.com/_/postgres


## ShardingSphare


```bash 

docker run -d -v /${your_work_dir}/conf:/opt/sharding-proxy/conf \
    -e PORT=3308 -p13308:3308 apache/sharding-proxy:4.1.1

# 配置相关jvm参数到JVM_OPTS参数中
docker run -d -v /${your_work_dir}/conf:/opt/sharding-proxy/conf \
     -e JVM_OPTS="-Djava.awt.headless=true" -e PORT=3308 -p13308:3308 apache/sharding-proxy:4.1.1

# psql -U ${your_user_name} -h ${your_host} -p 13308

```

> 参考： https://hub.docker.com/r/apache/sharding-proxy
>  /${your_work_dir}/conf 文件夹下，请创建server.yam和config-xxx.yaml去配置服务和分片规则
>  配置文件参考 https://shardingsphere.apache.org/document/legacy/4.x/document/cn/manual/sharding-proxy/configuration/



## 清理容器

```
docker ps -qa |xargs docker stop
docker ps -qa |xargs docker rm 
```