# Nexus3 docker安装

## 安装
```BASH
# 挂载目录运行
docker run -d \
    -p 8081:8081 -p 8082:8082 -p 8083:8083 -p 8084:8084 \
    -v /opt/nexus-data:/nexus-data --name nexus3 sonatype/nexus3 
# 不挂载目录运行，测试
docker run -d \
    -p 8081:8081 -p 8082:8082 -p 8083:8083 -p 8084:8084 \
     --name nexus3 sonatype/nexus3 
```

* 端口说明
  * 8081：nexus3网页端
  * 8082：docker(hosted)私有仓库，可以pull和push
  * 8083：docker(proxy)代理远程仓库，只能pull
  * 8084：docker(group)私有仓库和代理的组，只能pull

## 验证安装

* 获取密码   

```
docker exec -it $(docker ps | grep sonatype/nexus3 | \
     awk '{print $1}') cat /nexus-data/admin.password
```

* 网页访问 http://localhost:8081,使用admin和刚才获取的密码登录；



