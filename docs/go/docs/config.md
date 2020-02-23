# 常用配置和命令

```bash
# 关闭go mod
go env -w GO111MODULE=off
# 关闭go mod临时
export GO111MODULE=off
```

```bash 
# 添加依赖，重复执行该命令，可以用来升级
go get -u go.uber.org/zap
# 添加指定版本依赖。也可以用来更换依赖版本
go get -u go.uber.org/zap@v1.11
# 编译
go build ./
# 初始化mod文件
go mod init 
````