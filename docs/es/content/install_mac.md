# mac安装es

## 安装步骤 

```bash 
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.13.1-darwin-x86_64.tar.gz
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.13.1-darwin-x86_64.tar.gz.sha512
shasum -a 512 -c elasticsearch-7.13.1-darwin-x86_64.tar.gz.sha512 
tar -xzf elasticsearch-7.13.1-darwin-x86_64.tar.gz
# 该路径是变量$ES_HOME的路径
cd elasticsearch-7.13.1/ 

#  启动es 
./bin/elasticsearch
#  后台启动es，记录进程的pid到文件pid内
./bin/elasticsearch -d -p pid


# 验证es是否正常安装,如下命令返回集群的信息 
curl localhost:9200
## 返回信息如下：
{
  "name" : "Cp8oag6",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "AT69_T_DTp-1qgIJlatQqA",
  "version" : {
    "number" : "7.13.1",
    "build_flavor" : "default",
    "build_type" : "tar",
    "build_hash" : "f27399d",
    "build_date" : "2016-03-30T09:51:41.449Z",
    "build_snapshot" : false,
    "lucene_version" : "8.8.2",
    "minimum_wire_compatibility_version" : "1.2.3",
    "minimum_index_compatibility_version" : "1.2.3"
  },
  "tagline" : "You Know, for Search"
}

# 关闭es 
pkill -F pid


```