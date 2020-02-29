# select

## 简介 

select 可以实现多个channel协调统一调度。

## 例子

```go 
package main

import (
	"fmt"
	"math/rand"
	"time"
)

func generator() chan int{
	out := make(chan int)
	go func() {
		i := 0
		for {
			time.Sleep(time.Duration(rand.Intn(1500))* time.Millisecond)
			//time.Sleep(time.Duration(1500)* time.Millisecond)
			out <- i
			i++
		}
	}()
	return out
}

func main() {

	var c1,c2  = generator(), generator()
	tm := time.After(10* time.Second)
	tick := time.Tick(time.Second)
	for {
		select {
		case n := <-c1:
			fmt.Println("received form c1:",n)
		case n := <-c2:
			fmt.Println("received form c2:",n)
		case <- time.After(800* time.Millisecond)://距离上次产生数据 800 Ms,则打印超时
			fmt.Println("time out")
		case <- tick:								//每1S调用一次
			fmt.Println(" tick 1 second")
		case <-tm:								//举例启动超过 10s则结束
			fmt.Println("bye")
			return
		//default:
		//	fmt.Println("No value received")
		}
	}
}

```