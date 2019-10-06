# elasticsearch配置

Elasticsearch 配置了很好的默认参数.大多数参数可以通过 [Cluster 配置API修改](https://www.elastic.co/guide/en/elasticsearch/reference/current/cluster-update-settings.html).

配置文件应该包含一些节点特有的（node.name、 paths），或者是一些节点加入到集群中必须配置的参数，如cluster.name and network.host。

## 环境变量配置 

* ES_HOME=/path/to/es
* ES_PATH_CONF=$ES_HOME/config  
* ~~ES_PATH_CONF=$ES_HOME/config ./bin/elasticsearch~~

## 配置文件

* elasticsearch.yml  Elasticsearch配置
* jvm.options  Elasticsearch JVM 配置
* log4j2.properties  Elasticsearch 日志配置


## 配置文件格式

配置文件为YAML格式，可以配置如下：
```YAML
path:
    data: /var/lib/elasticsearch
    logs: /var/log/elasticsearch
```

也可以：  
```YAML
path.data: /var/lib/elasticsearch
path.logs: /var/log/elasticsearch
```

也可以在文件中引用环境变量
```YAML
node.name:    ${HOSTNAME}
network.host: ${ES_NETWORK_HOST}
```