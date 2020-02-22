# go语言类型  

* bool string 
* (u)int (u)int8 (u)int16 (u)int32 (u)int64 uintptr
* byte rune (go语言的char，32位)
* float32 float64 complex64 complex128 (复数）



## 常量
* 常量可以加一个const关键字即可

```go
const filename = "abc.txt"
const a, b = 3,4 
const (
  d, e = 5,6 
)
```

## 枚举 

```go 
	const(
		//iota表示const是自增值的
		cpp = iota
		//_表示跳过一个数
		_
		java
		php
	)
  fmt.Println(cpp)
  // 运算
	const(
		b = 1 << (10 * iota)
		kb
		mb
		gb
		tb
		pb
	)
```

## 类型转换

* go 语言内只有强制类型转换，没有隐式转换

```go
var c int = int(math.Sqrt(float64(3*3+4*4)))
```
