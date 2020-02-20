# go语言变量


如下图是变量的使用例子。

```go 
package main

import "fmt"

//包内的变量
var aa = 2

var (
	bb = 20
	cc = true
	ss = "sss"
)


func variable()  {
	//变量定义，使用关键字
	var a int
	var s string
	//fmt.Println(a,s)
	//%q会把引号带出来
	fmt.Println("variable")
	fmt.Printf("%d %q\n",a,s)
}

func initValue()  {
	//变量的初始化
	var a int=3
	var c,d int=3 ,4
	var s string = "abc"
	fmt.Println("initValue")
	fmt.Println(a,s)
	fmt.Println(c,d)
	fmt.Println(aa,bb,cc,ss)
}

func deductionType()  {
	//类型推断
	var a,b,c,d=3,4,true,"def"
	fmt.Println("deductionType")
	fmt.Println(a,b,c,d)
	//简写冒号赋值
	e,f,g,h := 3,4,true,"def"
	fmt.Println(e,f,g,h)
}

func main()  {
	fmt.Println("hello word")
	variable()
	initValue()
	deductionType()
}
```