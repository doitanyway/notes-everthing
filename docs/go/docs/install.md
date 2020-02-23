# 安装

* [官网下载安装包](https://golang.google.cn/dl/)安装go lang

* [国内网站](https://studygolang.com/dl)下载go lang

* [配置使用国内七牛云的 go module 镜像](https://github.com/goproxy/goproxy.cn)，具体方法如下:

* 其他地址: http://mirrors.ustc.edu.cn/golang/


```bash 
# unset GO111MODULE
# go env -w GO111MODULE=on
unset GOPROXY
go env -w GOPROXY=https://goproxy.cn,direct

export GO111MODULE=on
GOPATH=$(go env | grep GOPATH | sed "s/\"//g" | awk -F'=' '{print $2}')
cat << EOF >> ~/.zshrc
export GOPROXY=https://goproxy.cn,direct
export GOPATH=/Users/nick/go
export PATH=\$PATH:\$GOPATH/bin
export GO111MODULE=auto
EOF

```

