# 面向对象的可见性

## 简介

* 名字一般使用CamelCase命名法
* 首字母大写： public （针对包来说的）
* 首字母小写：private（针对包来说的）
* 为结构定义的方法必须在同一个包内
* 包可以定义在多个文件中

## 例子

* tree/entry/entry.go  
```go 
package main

import "fmt"
import "../../tree"


func main() {
	//	创建对象
	var root tree.TreeNode
	fmt.Println(root)

	// 添加节点
	root = tree.TreeNode{ Value:3}
	fmt.Println(root)
	root.Left = &tree.TreeNode{}
	root.Right = &tree.TreeNode{nil,nil,5}
	//在go 语言中，不管是指正，还是实例，都是用.号去访问
	root.Right.Left = new(tree.TreeNode)
	fmt.Println(root)
	root.Left.Right = tree.CreateNode(2)

	fmt.Println("traverse")
	root.Traverse()
}

```


* tree/node.go  

```go 
package tree

import "fmt"

//类的声明
type TreeNode struct {
	Left ,Right * TreeNode;
	Value int
}

//类的函数,指针接受者；  要改变内容使用指针接收者，结果过大也用指针接收者，一致性使用指针接收者
func (root * TreeNode) Traverse()  {
	if root == nil {
		return
	}
	root.Left.Traverse()
	fmt.Println(root.Value)
	root.Right.Traverse()
}

//值接收者，go语言特有的；结构的一个拷贝
func (node TreeNode) Print()  {
	fmt.Print(node.Value," ")
}


//工厂函数，用来创建对象，可以用它来代替构造函数,注意这里是返回的一个局部对象，局部对象在其他语言内做返回值是有错误的，但是在go语言中没有问题
func CreateNode(value int) * TreeNode {
	return &TreeNode{Value:value}
}
```