# Map

## 定义

```go
m := map[string] string {
  "name": "Nick",
  "age": "12",
  "sex": "male",
}
```


## 例子

```go 
package main

import "fmt"

func main() {

	//create map
	m := map[string] string {
		"name": "Nick",
		"age": "12",
		"sex": "male",
	}
	fmt.Println(m)

	m2 := make(map[string]int)	//m2 == empty map
	fmt.Println(m2)

	var m3 map[string]int		//m3 = nil
	fmt.Println(m3)

	//	map的遍历
	for k, v := range m{
		fmt.Println(k,v)
	}

	// map获取值
	name := m["name"]
	fmt.Printf("name=%v\n",name)

	name1 := m["name1"]
	fmt.Printf("name1=%v\n",name1)

	name2, ok := m["name2"]
	fmt.Printf("name2=%v,ok=%t\n",name2, ok)

	if name3, ok := m["name3"]; ok {
		fmt.Printf(name3)
	}else {
		fmt.Printf("can't find name3\n")
	}
	//set new value
	m["name"]="new name"
	fmt.Println(m)
}

```