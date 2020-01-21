# 安装

* [官网下载安装包](https://golang.google.cn/dl/)安装go lang

* [配置使用国内七牛云的 go module 镜像](https://github.com/goproxy/goproxy.cn)。



```bash 
# go env -w GO111MODULE=on
go env -w GOPROXY=https://goproxy.cn,direct

export GO111MODULE=auto
GOPATH=$(go env | grep GOPATH | sed "s/\"//g" | awk -F'=' '{print $2}')
cat << EOF >> ~/.zshrc
export GOPROXY=https://goproxy.cn
export GOPATH=/Users/nick/go
export PATH=\$PATH:\$GOPATH/bin
export GO111MODULE=auto
EOF

```

