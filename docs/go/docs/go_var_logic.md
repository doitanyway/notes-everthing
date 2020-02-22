# go语言逻辑


## if 

```go 
// 简单If例子
	a := 1
	if a == 1 {
		fmt.Println("a = 1")
	} else if a == 2{
		fmt.Println("a = 2")
	}else{
		fmt.Println("a = others ")
  }
// 读取文件
	const filename = "abc1.txt"
	if contents, err := 	ioutil.ReadFile(filename); err != nil{
		fmt.Println(err)
	}else{
		fmt.Printf("%s\n", contents)
	}
```

## switch 

```go 
	var op = "+"
	switch op {
	case "+":
		fmt.Println("+")
	case "-":
		fmt.Printf("-")
	default:
		panic("unsupported operator:"+ op)
	}
```


## for  

```go 
	sum := 0
	for i:=1 ; i<100; i++ {
		sum+= i
	}
	fmt.Println(sum)
```

```go 
func convertToBin(n int)  string{
	result := ""
	for ; n>0 ; n/=2  {
		lsb := n%2
		//strconv.Itoa(lsb) 转换字符串
		result = strconv.Itoa(lsb) + result
	}
	return result
}

func main()  {

	fmt.Println(
			convertToBin(5),
			convertToBin(13),
		)
}
```


```go
//读文件，省略开始和递增条件
func printFile(filename string)  {
	file, err := os.Open(filename)
	if err != nil{
		panic(err)
	}
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		fmt.Println(scanner.Text())
	}
}
//死循环
func forver()  {
	for  {
		fmt.Println("abc")
	}
}

func main()  {
	printFile("abc.txt")
	forver()
}
```