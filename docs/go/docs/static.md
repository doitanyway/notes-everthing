# go语言打包静态文件

## 简介

应用中，有时候我们需要打包静态文件到可执行文件内。该功能我们可使用模组``go-bindata``

## 使用方法

### 安装   

```
go get -u github.com/jteeuwen/go-bindata/...
```
> go get 地址最后的三个点 ...。这样会分析所有子目录并下载依赖编译子目录内容。go-bindata 的命令工具在子目录中。

###  工程准备  

* 文件目录 

```bash 
./
├── asset         --资源文件夹
│   ├── abc.json  --资源文件
│   └── abc.yaml  --资源文件
├── build.sh      --编译文件
├── dist          --输出文件夹
│   └── asset.go  --输出文件
├── go.mod        
├── go.sum
└── main.go       --入口文件
```


* ``asset/abc.json``  

```json 
{
  "name": "nick",
  "age": 12 ,
  "address": "nanshan"
}
```

* ``asset/abc.yaml``   

```yaml
student:
  name: nick
  age: 12
  address: Hi nick
```

* ``build.sh``  

```bash
#!/bin/bash

#go-bindata -o=app/asset/asset.go -pkg=asset source/... theme/... doc/source/... doc/theme/...
# -pkg指定包名
# -o  指定输出文件
# 后续指定多个文件或者文件夹  （...结尾表示很多）
go-bindata -o=dist/asset.go -pkg=asset asset/...

```


* ``main.go``     

```go
package main

import (
	asset "awesomeProject3/dist"
	"fmt"
)

func main() {
	data, err := asset.Asset("asset/abc.json")
	if err != nil {
		// Asset was not found.
		panic(err)
	}
	fmt.Printf("......asset/abc.json\n")
	fmt.Printf("%s\n",data)

	data, err = asset.Asset("asset/abc.yaml")
	if err != nil {
		// Asset was not found.
		panic(err)
	}
	fmt.Printf("......asset/abc.yaml\n")
	fmt.Printf("%s\n",data)
}
```

## 执行

* 静态文件生成go文件  

```bash 
sh build.sh 
```

* 运行程序，执行结果如下： 

```bash 
gn/T/___go_build_awesomeProject3 #gosetup
......asset/abc.json
{
  "name": "nick",
  "age": 12 ,
  "address": "nanshan"
}
......asset/abc.yaml
student:
  name: nick
  age: 12
  address: Hi nick
```