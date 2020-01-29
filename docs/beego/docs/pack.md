# 编译打包


## 编译命令（LINUX&Mac）

```bash 
# 缺省命令
CGO_ENABLED=0 bee pack

# 打包的程序可在mac上执行
CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build main.go
# 打包Linux上执行的程序
CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build main.go
# 打包Windows 64位可执行程序
CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build main.go

```

## windows平台

windows使用bat脚本  

```bash
# 打包windows 64程序
SET CGO_ENABLED=0
SET GOOS=windows
SET GOARCH=amd64
go build main.go

# 打包mac程序
SET CGO_ENABLED=0
SET GOOS=darwin
SET GOARCH=amd64
go build main.go

# 打包linux程序
SET CGO_ENABLED=0
SET GOOS=linux
SET GOARCH=amd64
go build main.go
```



## 变量说明

> GOOS：目标平台的操作系统（darwin、freebsd、linux、windows）
> GOARCH：目标平台的体系架构（386、amd64、arm）
> 交叉编译不支持 CGO 所以要禁用它



## 执行

### 独立部署 

 

```bash 
nohup ./beepkg &
```