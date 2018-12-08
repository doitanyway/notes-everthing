# 容器指定ip


## 命令设置办法

```
docker network create --subnet=10.5.0.0/16 vpcbr
docker network ls
docker run -itd --name networkTest --net vpcbr --ip 10.5.0.10 centos:latest /bin/bash
```

## docker-compose设置办法

```yaml
version: '3'
services:
  redis_server:
    build: ./redis/
    ports:
     - "6379:6379"
     - "6479:6479"
     - "6579:6579"
     - "26379:26379"
    tty: true
    networks:
      vpcbr: 
        ipv4_address: 10.5.0.6    # 指定ip地址
  redis_server:
    build: ./redis/
    ports:
     - "6379:6379"
     - "6479:6479"
     - "6579:6579"
     - "26379:26379"
    tty: true
    networks:
      - vpcbr                   # 指定网络，但是不指定ip地址
networks:
  vpcbr:
    driver: bridge
    ipam:
     config:
       - subnet: 10.5.0.0/16
```