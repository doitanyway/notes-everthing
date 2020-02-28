# coroutine-协程

## 简介

go语言对多协程支持比其他语言更好。加一个go关键字就可以让函数多协程处理。


## 例

```go 
package main

import (
	"fmt"
	"runtime"
	"time"
)

func main() {

	var a [10] int
	for i:=0;i<10 ;i++  {
		//多协程运行
		go func(i int) {
			for   {
				a[i]++
				//交出控制器，主动的交出CPU控制器
				runtime.Gosched()
			}
		}(i)
	}
	time.Sleep(time.Millisecond)
	fmt.Println(a)
}

```