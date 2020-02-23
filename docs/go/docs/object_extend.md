# 面向对象-扩展已有类型

* 通过组合扩展已有类型

* 通过别名方法扩展已有类型



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

