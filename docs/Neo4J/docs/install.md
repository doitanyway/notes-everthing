# 安装Neo4j


## centos 7 安装

```bash 
# 安装jdk 11
curl https://gitee.com/nickqiu/notes-everything/raw/master/docs/Linux/content/install/jdk11_install.sh | bash 


# 安装neo4j
curl https://gitee.com/nickqiu/notes-everything/raw/master/docs/Neo4J/docs/neo4j_install.sh | bash 


# 卸载neo4j
curl https://gitee.com/nickqiu/notes-everything/raw/master/docs/Neo4J/docs/neo4j_remove.sh | bash 


# 卸载jdk
curl https://gitee.com/nickqiu/notes-everything/raw/master/docs/Linux/content/install/jdk_remove.sh | bash 

```


## 修改默认配置 


* 网页端口7474，打开远端访问，``/path/of/neo4j/conf/neo4j.conf``
```
dbms.connector.http.listen_address=0.0.0.0:7474
```


## 访问  

```bash  
# ip 地址,进入该数据库的管理界面，默认账户/密码  neo4j/neo4j  
http://{ip}:7474

```

## 参考

https://blog.csdn.net/anshenwa4859/article/details/102005175