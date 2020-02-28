# 例子：自己实现Reader

## 说明


* io.Reader接口，定义如下  

```go
type Reader interface {
	Read(p []byte) (n int, err error)
}
```

## 例子  

```go 
package main

import (
	"bufio"
	"fmt"
	"io"
	"os"
	"strings"
)

func printFile(filename string)  {
	file,err := os.Open(filename)
	if err!= nil{
		panic(err)
	}
	printFileContents(file)
}

func printFileContents(reader io.Reader)  {
	scanner := bufio.NewScanner(reader)
	for scanner.Scan(){
		fmt.Println(scanner.Text())
	}
}

func main()  {
	fmt.Println("test")
	printFile("./printfile/test.md" )
	s := `abc"d"
		wwwdd\dad 
		12344  
		da`
	printFileContents(strings.NewReader(s))
}


```

