# godoc

## 简介

godoc可以结合注释生成一些帮助文档。在新的版本中godoc需要安装  
```bash 
go get golang.org/x/tools/cmd/godoc
```


## godoc使用  

* 准备代码： test/queue.go  
```go 
package queue

//An FIFO queue
type Queue []int

//推送数据到队列里面去
func (q*Queue) Push (v int)  {
	* q = append(*q,v)
}

//在队列中探出一个数据
func (q*Queue) Pop () int  {
	head := (*q)[0]
	*q = (*q)[1:]
	return head
}

//判断队列是否是空
func (q*Queue) IsEmpty()bool  {
	return len(*q) == 0
}
```

* 准备代码：``test/queue_test.go``（测试代码和example） 
```go 
package queue

import "fmt"

func ExampleQueue_Pop() {
	q := Queue{1}
	q.Push(2)
	q.Push(3)
	fmt.Println(q.Pop())
	fmt.Println(q.Pop())
	fmt.Println(q.IsEmpty())
	fmt.Println(q.Pop())
	fmt.Println(q.IsEmpty())

	//添加入下注释，才会在godoc里面显示该函数的列子，同时这个也会作为一个测试用例
	//Output:
	//1
	//2
	//false
	//3
	//true
}
```

```bash 
# http服务
godoc -http :8080 
```