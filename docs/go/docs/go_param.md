# go语言参数传递

```go 
package main

import (
	"fmt"
)

//值传递，拷贝一个新的变量
func f( a int )  {
	fmt.Println(a)
	a = 20
}
//引用传递例子
func swap(a , b * int )  {
	*b, * a = * a ,*b
}

func main()  {
	var a int = 10
	f(a)

	a,b := 3,4
	swap(&a,&b)
	println(a,b)
}
```