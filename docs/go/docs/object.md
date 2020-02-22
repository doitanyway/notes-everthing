# 面向对象


## 简介
go 语言中没有对象，和c语言类似，通过struct实现面向对象的程序编写，如下图：TreeNode 定义了Left 、Right、Value属性，和traverse方法。

* go语言的面向对象仅仅支持封装，不支持继承、多态
* go语言中没有构造函数


```go 
import "fmt"

type TreeNode struct {
	Left ,Right * TreeNode;
	Value int
}

func (root * TreeNode) traverse()  {
	if root == nil {
		return
	}
	root.Left.traverse()
	fmt.Println(root.Value)
	root.Right.traverse()
}
```

## 例子

* 对象的使用例子  

```go 
package main

import "fmt"

//类的声明
type TreeNode struct {
	Left ,Right * TreeNode;
	Value int
}

//类的函数,指针接受者；  要改变内容使用指针接收者，结果过大也用指针接收者，一致性使用指针接收者
func (root * TreeNode) traverse()  {
	if root == nil {
		return
	}
	root.Left.traverse()
	fmt.Println(root.Value)
	root.Right.traverse()
}

//值接收者，go语言特有的；结构的一个拷贝
func (node TreeNode) print()  {
	fmt.Print(node.Value," ")
}


//工厂函数，用来创建对象，可以用它来代替构造函数,注意这里是返回的一个局部对象，局部对象在其他语言内做返回值是有错误的，但是在go语言中没有问题
func createNode(value int) * TreeNode {
	return &TreeNode{Value:value}
}

func main() {
	//	创建对象
	var root TreeNode
	fmt.Println(root)

	// 添加节点
	root = TreeNode{ Value:3}
	fmt.Println(root)
	root.Left = &TreeNode{}
	root.Right = &TreeNode{nil,nil,5}
	//在go 语言中，不管是指正，还是实例，都是用.号去访问
	root.Right.Left = new(TreeNode)
	fmt.Println(root)
	root.Left.Right = createNode(2)

	fmt.Println("traverse")
	root.traverse()
}

```