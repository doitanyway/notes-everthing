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



* 例子3,使用函数式编程访问树：   

```go 
package main

import "fmt"

type Node struct {
	Value int
	Left, Right * Node
}

func (node * Node) Print()  {
	fmt.Println(node.Value," ")
}
/**
   遍历树
 */
func (node * Node) Traverse()  {
	if node == nil{
		return
	}
	node.Left.Traverse()
	node.Print()
	node.Right.Traverse()
}
/**
	通过函数式编程遍历树
 */
func (node * Node) TraverseF( f func(* Node))  {
	if node == nil{
		return
	}
	node.Left.TraverseF(f)
	f(node)
	node.Right.TraverseF(f)
}




func main() {

	var root Node
	root = Node{Value:3}
	root.Left = &Node{Value:1}
	root.Right = &Node{5,nil,nil}
	count := 0
	//在运行的时候确定遍历处理函数
	root.TraverseF(func(node *Node) {
		fmt.Print(node.Value, " ")
		count++
	})
	fmt.Println()
	fmt.Println("count =",count)
}


```

### 闭包

闭包是匿名函数与匿名函数所引用环境的组合。匿名函数在内部不用参数传递就可以引用外部的变量，


*  例子1

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

* 例子2：

```go 
package main

import (
	"bufio"
	"fmt"
	"io"
	"strings"
)

func fibonacci() intGen  {
	a, b := 0,1
	return func() int {
		a ,b = b, a+b
		return a
	}
}

type intGen func() int

func (g intGen) Read(
	p []byte) (n int, err error) {
	next := g()
	if next > 1000{
		return 0,io.EOF
	}
	s := fmt.Sprintf("%d\n",next)
	return strings.NewReader(s).Read(p)
	//return next, nil
}

func printFileContents(reader io.Reader)  {
	scanner := bufio.NewScanner(reader)
	for scanner.Scan(){
		fmt.Println(scanner.Text())
	}
}

func main() {
	f := fibonacci()
	printFileContents(f)
}


```
