# 接口

## 简介

* 接口描述了对象的能力（函数）；
* go语言中，接口的实现无关键字；
* 如果struct有接口的方法，则表示该struct实现了该接口。


## 例子

* downloader.go  

```go
package main

import (
	"fmt"
	"gomodtest/tools"
)

//获取接口的实现对象
func getRetriever()  retriever {
	return tools.Retriever{}
}

//接口定义
type retriever interface {
	Get(string) string
}

func main() {
	//接口的使用
	var r retriever = getRetriever()
	str := r.Get("https://www.baidu.com")
	fmt.Printf(str)
}

```

* tools/Retriever.go,接口实现函数1  
```go 
package tools

import (
	"io/ioutil"
	"net/http"
)

type Retriever struct {
	
}
func (Retriever) Get(url string)string  {
	resp,err := http.Get(url)

	if err != nil{
		panic(err)
	}

	defer resp.Body.Close()

	bytes,_  := ioutil.ReadAll(resp.Body)
	return string(bytes)
}
```

* tools/test/Retriever.go，接口实现2  
```go
package test

type Retriever struct {
}


func (Retriever) Get( url string) string {
	return "fake content"
}
```