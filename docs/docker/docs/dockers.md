# 常用docker容器


* centos 

```bash 
docker run -d centos tail -f /dev/null
```

* mysql 

```bash
docker run --name some-mysql  \
   -v $PWD/datadir:/var/lib/mysql \
    -e MYSQL_ROOT_PASSWORD=123456 -p 3307:3306 -d mysql:5.7
```

* 