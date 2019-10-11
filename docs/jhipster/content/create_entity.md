# 创建entity

## 使用命令行生成实体

```BASH
# 命令格式
jhipster entity <entityName> --[options]

```

* 可以通过jhipster entity --help获取帮助
* options可以有如下参数
  * --table-name <table_name> - 默认情况下jhipster会根据实体的名字给table取名，如果需要自定义名字的话，可以加入该字段.
  * --angular-suffix <suffix> - 如果我们期望所有的angular路由都有一个自定义的前缀，可以使用该选项.
  * --client-root-folder <folder-name> - 在客户端使用一个跟文件文件目录保存entity. 对于单体应用默认为空，对于微服务API网关应用默认是服务的而明朝.
  * --regenerate - 重新生成一个已经存在的实体，不提示.
  * --skip-server - 这将会只生成客户端代码；
  * --skip-client - 这将只生成服务端代码
  * --db - 指定数据库


* 例子 
```BASH 
# 添加一个名字为book的实体
jhipster entity book

# 添加如下属性
a “title”, of type “String”
a “description”, of type “String”
a “publicationDate”, of type “LocalDate”
a “price”, of type “BigDecimal”

```

## [使用JDL Studio生成](https://start.jhipster.tech/jdl-studio/)

* JDL全名为(Jhipster domain language)

```bash
jhipster import-jdl your-jdl-file.jh
```