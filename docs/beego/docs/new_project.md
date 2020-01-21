# 新建项目


## 创建一个测试项目

```BASH 
cd $GOPATH/src

# export GO111MODULE=auto
# 新建项目
bee new quickstart
cd quickstart
go mod init
# 运行项目
bee run 

```

# 验证  

访问服务器http://localhost:8080/ 可以看到如下页面 ： 


![](./assets/2020-01-21-12-20-31.png)