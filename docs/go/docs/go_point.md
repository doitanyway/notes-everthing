# go语言指针


* go语言指针例子如下，go语言的指针不能做运算

```go 
var a int = 2
var pa * int = &a 
* pa = 3
fmt.Println(a)
```


