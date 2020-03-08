# json

## 简介

javascript表示对象的方法简称json,go语言对json有良好的支持


## 对象转json  

```go 
package main

import (
	"encoding/json"
	"fmt"
	"log"
)
// public 对象转换时候才会被显示出来
type Student struct {
	Name string
	Age int `json:"年龄"`
	Mobile string
}

var students = []Student{
	{Name:"Nick",Age:12,Mobile:"123"},
	{Name:"Jessica",Age:12,Mobile:"18888888"},
}

func main() {
  // data, err := json.Marshal(students)
  // 格式化输出
  data, err := json.MarshalIndent(students, "", "    ")
	if err != nil {
		log.Fatalf("JSON marshaling failed: %s", err)
	}
	fmt.Printf("%s\n", data)
}

```


## json转对象

* 读取部分数据  

```go 
var data = `[{"Name":"Nick","年龄":12,"Mobile":"123"},{"Name":"Jessica","年龄":12,"Mobile":"18888888"},{"Name":"Lucy","年龄":20,"Mobile":"122222"}]`

func main() {
	var names []struct{ Name string }
	if err := json.Unmarshal([]byte(data), &names); err != nil {
		log.Fatalf("JSON unmarshaling failed: %s", err)
	}
	d, _ := json.Marshal(names)
	log.Printf("%s",d)
}
```

* 读取全部数据  

```go 

type Student struct {
	Name string
	Age int  `json:"年龄"`
	Mobile string
}

var data = `[{"Name":"Nick","年龄":12,"Mobile":"123"},{"Name":"Jessica","年龄":12,"Mobile":"18888888"},{"Name":"Lucy","年龄":20,"Mobile":"122222"}]`

func main() {
	names := make([] Student,0)
	if err := json.Unmarshal([]byte(data), &names); err != nil {
		log.Fatalf("JSON unmarshaling failed: %s", err)
	}
	d, _ := json.Marshal(names)
	log.Printf("%s",d)
}

```



* 嵌套对象  

```go  
package main

import (
	"encoding/json"
	"log"
)

type Student struct {
	Name string
	Age int  `json:"年龄"`
	Mobile string
	StuAddress Address
}

type Address struct {
	City string
	Street string
}

var data = `
[
    {
        "Name": "Nick",
        "年龄": 12,
        "Mobile": "123",
        "StuAddress": {
            "City": "北京",
            "Street": "长安街"
        }
    },
    {
        "Name": "Jessica",
        "年龄": 12,
        "Mobile": "18888888"
    }
]`

func main() {

	names := make([] Student,0)
	if err := json.Unmarshal([]byte(data), &names); err != nil {
		log.Fatalf("JSON unmarshaling failed: %s", err)
	}
	d, _ := json.Marshal(names)
	log.Printf("%s",d)
}


```