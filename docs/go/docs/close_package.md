# 闭包&匿名函数

## 简介

### 匿名函数 

匿名函数的定义就是: 没有名字的普通函数，大致格式如下：  

```go
func (参数列表) (返回值列表) {
    函数体
} 
```

* 例： 

```go 
func main() {
    // 定义匿名函数并赋值给f变量
    f := func(data int) {
      fmt.Println("hello", data)
    }
    // 此时f变量的类型是func(), 可以直接调用
    f(100)
}
```
> go语言中函数作为一等公民，可以向普通类型（int、float）一样进行赋值、作为函数的参数传递

## 例子

```go
package main

import "fmt"

func adder() func(value int) int  {
	sum := 0
	return func(value int) int {
		sum += value
		return sum
	}
}

func main()  {
	adder := adder()
	for i:=0; i<10 ;i++  {
		fmt.Println(adder(i))
	}
}

```