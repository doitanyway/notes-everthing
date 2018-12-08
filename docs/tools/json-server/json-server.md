# json-server

在做前后端分离开发的时候，前端开发经常遇到后端程序还未开发好，这时我们需要模拟出一个restfull服务器，此时json-server不失为一个好的选择；

该工具支持GET, POST, PUT, PATCH 和 DELETE 方法，且提供了limit，order等方法。



## 安装

```
# mac需要加 sudo 
npm install json-server -g

# 验证安装，查看使用方法
json-server -h 
```


## 创建config文件 db.json

```json
{
  "news":[
    {
     "id" : 1,
     "title": "this is a big news ",
     "date": "2018-12-12 12:00:00"
    }, 
    {
      "id": 2,
      "title": "this is not a big news",
      "date": "2018-12-13 12:00:00"
    }
  ],
  "comments": [
    {
      "id": 1,
      "news_id": 1, 
      "content": "评论1"
    }, 
     {
      "id": 2,
      "news_id": 1, 
      "content": "评论2"
    }
  ]
}
```

* 运行 ```json-server db.json -p 3003``

> 为了方便，可创建一个 package.json 文件，写入