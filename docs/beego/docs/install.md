# 安装

## 安装


```bash 
# 安装

GO111MODULE=on go get github.com/astaxie/beego
GO111MODULE=on go get  github.com/beego/bee
GO111MODULE=off go get -u github.com/beego/bee



# 升级
go get -u github.com/astaxie/beego
go get -u github.com/beego/bee


cd $GOPATH/bin/
mkdir -p github.com/astaxie
cd github.com/astaxie
git clone https://github.com/astaxie/beego.git
go get -u github.com/astaxie/beego
go get -u github.com/beego/bee
```

