# 面向对象-扩展已有类型

* 通过组合扩展已有类型(最常用)

* 通过别名方法扩展已有类型

* 通过内嵌扩展已有类型（能够省下代码）


## 通过组合

```go 
package main

import "fmt"
import "../../tree"
// 包含原有的类
type myTreeNode struct {
	node * tree.TreeNode
}
// 新写一个方法
func (myNode * myTreeNode) postOrder()  {
	if myNode == nil || myNode.node == nil {
		return
	}
	left := myTreeNode{myNode.node.Left}
	right := myTreeNode{myNode.node.Right}
	left.postOrder()
	right.postOrder()
	myNode.node.Print()
}

func main() {
	
  fmt.Println()
  // 使用该方法
	myRoot := myTreeNode{&root}
	myRoot.postOrder()
}

```


## 别名方式 

* queue/queue.go  

```go 
package queue

type Queue [] int

func (q *Queue) Push( v int)  {
	*q = append(*q,v)
}

func (q * Queue) Pop() int  {
	head := (*q)[0]
	*q = (*q)[1:]
	return head
}

func (q* Queue) IsEmpty()  bool{
	return len(*q) == 0
}
```

* queue/entry/main.go  
```go 
package main

import (
	"../../queue"
	"fmt"
)

func main()  {

	q := queue.Queue{1}

	q.Push(2)
	q.Push(3)

	fmt.Println(q.Pop())
	fmt.Println(q.Pop())
	fmt.Println(q.IsEmpty())
	fmt.Println(q.Pop())
}
``` 

## 通过内嵌

```go 
package main

import "fmt"
import "../../tree"

//内嵌的方法扩展
type myTreeNode struct {
	*tree.Node //内嵌，直接只写类型,相当于把Node里面的成员变量全部拉出来给myTreeNode使用
}

func (myNode * myTreeNode) postOrder()  {
	if myNode == nil || myNode.Node == nil {
		return
	}
	left := myTreeNode{myNode.Left}		//myNode.Node.Left 省却了.Node
	right := myTreeNode{myNode.Right}
	left.postOrder()
	right.postOrder()
	myNode.Node.Print()
}

func main() {
	//	创建对象
	var root tree.Node
	fmt.Println(root)

	// 添加节点
	root = tree.Node{ Value: 3}
	fmt.Println(root)
	root.Left = &tree.Node{}
	root.Right = &tree.Node{nil,nil,5}
	//在go 语言中，不管是指正，还是实例，都是用.号去访问
	root.Right.Left = new(tree.Node)
	fmt.Println(root)
	root.Left.Right = tree.CreateNode(2)

	fmt.Println("traverse")
	root.Traverse()

	fmt.Println()
	myRoot := myTreeNode{&root}
	myRoot.postOrder()
}
```

> 内嵌，直接只写类型,相当于把Node里面的成员变量全部拉出来给myTreeNode使用
> 内嵌和继承有一些类似
> 在内嵌处理之后的新类里面重写一个方法，会产生一个shadow method

