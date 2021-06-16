# es

* [mac安装es](./content/install_mac.md)
* [mac安装kibana](./content/install_mac_kinba.md)
* [linux安装es](./content/install_linux.md)
* [docker安装es](./content/install_docker.md)
* [安装高可用es](./content/install_ha.md)
* [es的核心概念](./content/es_core.md)
* [es基本操作](./content/es_basic.md)
* [es的mapping](./content/mapping.md)
* [文档的基本操作](./content/document.md)
* [搜索命令](./content/search_cmd.md)
  

# 分词器

## 定义

分词器的定义：将文本按一定逻辑分解成为多个单词

ES默认的分词器：

* standard analyzer,标准分词器，默认使用该分词器
* simple analyzer,去掉不是字母的字符，然后再分词
* whitespace analyzer，使用空格分词
* stop analyzer，与simple分词器类似，不过分词结果删除掉了停止词，如（the , a ,an ,this ,of,at ,in等）
* language analyzer，指定语言的分词器，如english
* pattern analyzer，正则分词器


## 分词器练习

```bash 
# >>>查看字符串分词结果
curl -X POST "localhost:9200/_analyze?pretty" -H "Content-Type: application/json" -d '
{
  "analyzer": "standard",
  "text": "Hello my word! 中国"
}
'

# <<<返回分词后的结果
{
  "tokens" : [
    {
      "token" : "hello",
      "start_offset" : 0,
      "end_offset" : 5,
      "type" : "<ALPHANUM>",
      "position" : 0
    },
    {
      "token" : "my",
      "start_offset" : 6,
      "end_offset" : 8,
      "type" : "<ALPHANUM>",
      "position" : 1
    },
    {
      "token" : "word",
      "start_offset" : 9,
      "end_offset" : 13,
      "type" : "<ALPHANUM>",
      "position" : 2
    },
    {
      "token" : "中",
      "start_offset" : 15,
      "end_offset" : 16,
      "type" : "<IDEOGRAPHIC>",
      "position" : 3
    },
    {
      "token" : "国",
      "start_offset" : 16,
      "end_offset" : 17,
      "type" : "<IDEOGRAPHIC>",
      "position" : 4
    }
  ]
}


# 发送简单分词器
curl -X POST "localhost:9200/_analyze?pretty" -H "Content-Type: application/json" -d '
{
  "analyzer": "simple",
  "text": "Hello my word! 中国"
}
'

# 应答，发现感叹号被去掉了
{
  "tokens" : [
    {
      "token" : "hello",
      "start_offset" : 0,
      "end_offset" : 5,
      "type" : "word",
      "position" : 0
    },
    {
      "token" : "my",
      "start_offset" : 6,
      "end_offset" : 8,
      "type" : "word",
      "position" : 1
    },
    {
      "token" : "word",
      "start_offset" : 9,
      "end_offset" : 13,
      "type" : "word",
      "position" : 2
    },
    {
      "token" : "中国",
      "start_offset" : 15,
      "end_offset" : 17,
      "type" : "word",
      "position" : 3
    }
  ]
}


```

## 中文分词器

* standard分词器分中文，会把中文字符串的每个字都分开
* smartCn，中英文分词器 (插件名称:analysis-smartcn)
  * 安装分词器,bin目录下执行命令``sh elasticsearch-plugin install analysis-smartcn``,安装后重新启动es
  * 卸载分词器，bin目录下执行命令``sh elasticsearch-plugin remove analysis-smartcn``,安装后重新启动es

* IK分词器
  * 安装分词器：  
    * 下载:https://github.com/medcl/elasticsearch-analysis-ik/release （版本需要和es相同）
    * 解压到plugins目录
    * 安装后重启
    * 验证插件安装

```bash 
curl -X POST "localhost:9200/_analyze" -H 'Content-type: application/json' -d '
{
  "analyzer": "ik_max_word",
  "text": "解析中文需要这个插件"
}
'
```

## 创建索引时指定分词器

```bash 
# 
curl -X PUT "localhost:9200/test_index" -H "Content-Type: application/json" -d '
{
  "settings": {
    "analysis": {
      "analyzer":{
        "my_analyzer":{
          "type": "whitespace"
        }
      }
    }
  },
  "mappings": {
    "properties":{
      "name": {
        "type": "text",
        "analyzer": "my_analyzer"
      },
       "age": {
        "type": "long" 
      }
    }
  }
}
'

```