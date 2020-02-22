# go语言数组

```go 
package main

import "fmt"

func main()  {
	var arr1 [] int
	//初始化
	arr2 := [3]int {1,2,5}
	//编译器来确定个数
	arr3 := [...]int {2,3,4,6,7}
	//二位数组
	var grid[4][5] int

	fmt.Println(arr1)
	fmt.Println(arr2)
	fmt.Println(arr3)
	fmt.Println(grid)

	//数组遍历方法1
	fmt.Println("..........arr3:",arr3)
	for i:=0 ; i<len(arr3);i++{
		fmt.Println(arr3[i])
	}
	//数组遍历方法2
	fmt.Println("..........arr3:",arr3)
	for i,v := range arr3 {
		fmt.Println(i, v)
	}
	//数组遍历方法3，省略变量
	fmt.Println("..........arr3:",arr3)
	for _,v := range arr3 {
		fmt.Println(v)
	}
	//数组遍历方法3，省略变量
	fmt.Println("..........arr3:",arr3)
	for _,v := range arr3 {
		fmt.Println(v)
	}

}

```

> 函数调用数组的时候 [10]int 和[20]int是不同类型
> 调用func f (arr [10] int)会``拷贝``数组
> go语言一般不直接使用数组，而是使用切片 

