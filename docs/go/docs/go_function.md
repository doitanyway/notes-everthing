# go语言函数

## 基本语法

```go
//  
func funcationname(a, b int,op string) int  
```

## 例子

```go 
package main

import (
	"fmt"
	"math"
	"reflect"
	"runtime"
)

//函数声明
func add(a, b int ) int  {
	return a+b
}
//有多个返回值的函数
func div(a ,b int ) (int, int ) {
	return a/b, a %b
}

//有多个返回值的函数,返回值取名
func div1(a ,b int ) (q,r  int ) {
	q = a/b
	r = a % b
	return
}

//多返回值，错误处理
func eval(a, b int ,op string) (int,error) {
	switch op {
	case "+":
		return a+b, nil
	case "-":
		return a-b, nil
	default:
		return 0, fmt.Errorf(
			"unsupported operation:%s", op)
	}
}
//使用函数作为参数
func apply(op func(int ,int )int , a, b int ) int  {
	p := reflect.ValueOf(op).Pointer()
	opName := runtime.FuncForPC(p).Name()
	fmt.Printf("Calling funcation %s with args (%d,%d)",opName,a,b)
	return op(a,b)
}

func pow(a,b int )  int  {
	return int(math.Pow(float64(a),float64(b)))
}

//可变参数
func sum(numbers ... int )  int{
	s := 0
	for i := range numbers{
		s += numbers[i]
	}
	return s
}

func main()  {
	fmt.Println(add(1,2))
	fmt.Println(div(13,3))
	q, r := div1(15, 4)
	fmt.Println(q,r)
	//该用法可以忽略第二个r的返回值
	//q, _ := div1(15, 4)

	if result, err := eval(3, 4, "+"); err!=nil{
		fmt.Println("Error:",err)
	}else {
		fmt.Println(result)
	}

	fmt.Println(apply(pow,3,4))
	fmt.Println(apply(func(a int, b int) int {
		return int(math.Pow(float64(a),float64(b)))
	},3,4))

	fmt.Println(sum(1,3,4,5))
}

```