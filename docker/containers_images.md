# containers & images

## 使用mongodb 

* image 地址： https://hub.docker.com/_/mongo/
* 运行mogodb ``docker run -p 27017:27017 --name some-mongo  -d mongo``
* 查看日志： ``docker logs -f 84d5c0580852``


## 重启container之后数据消失

默认情况下，重启mogo容器里面的数据也会消失，该特性在开发的时候很有用，自动清除多余的数据，但是如果我们需要持久化数据，可以把container映射到一个文件目录下即可。

```
docker run -p 27017:27017 -v /Users/fangle/dockerdata/mongo:/data/db -d mongo
```