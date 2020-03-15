# go语言模板

## 简介 

go语言中有2个模板``text/template`` 和 ``html/template`` 。


## 例子  

### 简单模板应用  

```go 
package main

import (
	"os"
	"text/template"
)

func main() {
	name := "world"
	//新建一个text模板
	tmpl, err := template.New("test").Parse("hello, {{.}}") //建立一个模板，内容是"hello, {{.}}"
	if err!=nil {
		panic(err)
	}
	//合成模板，变量name的内容会替换掉{{.}},并输出到标准输出中去  ``hello, world``
	err = tmpl.Execute(os.Stdout, name)
	if err!=nil {
		panic(err)
	}
}

```

> {{ 和 }} 包裹的内容统称为 action，其分为了2类
> * 数据求值（data evaluations）,被直接把值拷贝到模板中
> * 控制结构（control structures），条件、循环、变量、函数调用等


### 结构带入  

模板中的数据，可以和结构映射，如：


```go 
package main

import (
	"os"
	"text/template"
)

func main() {
	//结构
	type Student struct {
		Name string
		Age    uint
	}
	//结构实例
	student := Student{
		Name: "Nick",
		Age:  12,
	}
	tmpl, err := template.New("test").Parse("{{.Name}} is {{.Age}} years old.")
	if err!=nil {
		panic(err)
	}
	//合成模板,并输出到标准输出中去，student中的具体指，被传入进去
	err = tmpl.Execute(os.Stdout, student)
	if err!=nil {
		panic(err)
	}
}

```

### 模板文件

模板出了可以使用字符串之外，还可以使用 


* 模板文件  

```tml 
{{.Name}}  is {{.Age}} years old.
```

* 程序  

```go 
package main

import (
	"os"
	"text/template"
)

func main() {
	//结构
	type Student struct {
		Name string
		Age    uint
	}
	//结构实例
	student := Student{
		Name: "Nick",
		Age:  12,
	}
	//tmpl, err := template.ParseFiles("demo.go.tpl")
	tmpl, err := template.ParseFiles("template/textfile/demo.go.tpl")
	if err!=nil {
		panic(err)
	}
	//合成模板,并输出到标准输出中去，student中的具体指，被传入进去
	err = tmpl.Execute(os.Stdout, student)
	if err!=nil {
		panic(err)
	}
}
```

### 多模板 

一个模板对象可以支持多个模板文件，使用方法如下：  

```go 
package main

import (
	"fmt"
	"os"
	"text/template"
)

func main() {
	//结构
	type Student struct {
		Name string
		Age    uint
	}
	//结构实例
	student := Student{
		Name: "Nick",
		Age:  12,
	}
	tmpl, err := template.New("test").Parse("{{.Name}} is {{.Age}} years old.")
	if err!=nil {
		panic(err)
	}
	//添加一个模板文件
	tmpl, err = tmpl.New("test2").Parse("2........{{.Name}} is {{.Age}} years old.")
	if err!=nil {
		panic(err)
	}
	//选取模板执行
	err = tmpl.ExecuteTemplate(os.Stdout, "test", student)
	if err!=nil {
		panic(err)
	}
	fmt.Println()
	//选取模板执行
	err = tmpl.ExecuteTemplate(os.Stdout, "test2", student)
	if err!=nil {
		panic(err)
	}
	fmt.Println("")
	fmt.Println(tmpl.Name())
	tmpl = tmpl.Lookup("test") //切换模板，必须要有返回，否则不生效
	fmt.Println(tmpl.Name())
}

```

###  结果输出到文件 

```go 
package main

import (
	"os"
	"text/template"
)

func main() {
	//结构
	type Student struct {
		Name string
		Age    uint
	}
	//结构实例
	student := Student{
		Name: "Nick",
		Age:  12,
	}
	tmpl, err := template.New("test").Parse("{{.Name}} is {{.Age}} years old.")
	if err!=nil {
		panic(err)
	}
	//新建一个输出文件，添加读写权限
	file, err := os.OpenFile("demo.txt", os.O_CREATE|os.O_WRONLY, 0755)
	if err!=nil {
		panic(err)
	}
	//合成模板,并输出到文件中去，student中的具体指，被传入进去
	err = tmpl.Execute(file, student)
	if err!=nil {
		panic(err)
	}
}

```

## 循环   

```go 
package main

import (
	"os"
	"text/template"
)

func main() {
	//结构
	type Student struct {
		Name string
		Age    uint
	}
	type NewStudents struct {
		Students [] Student
	}
	//结构实例
	students := NewStudents{
		Students: [] Student{
			Student{ Name: "Nick", Age:20},
			Student{ Name: "Elaine", Age:19},
		},
	}

	var Text = `
{{ range .Students }}
{{.Name}} is {{.Age}} years old
{{- end }}
`

	tmpl, err := template.New("test").Parse(Text)
	if err!=nil {
		panic(err)
	}
	//合成模板,并输出到标准输出中去，student中的具体指，被传入进去
	err = tmpl.Execute(os.Stdout, students)
	if err!=nil {
		panic(err)
	}
}

```

### 模板函数

模板函数可以对变量进行一些函数处理，可以用来处理复杂一点的字段  

```go 
// 模板函数的类型
type FuncMap map[string]interface{}
// 模板函数声明
t = t.Funcs(template.FuncMap{"handleFieldName": HandleFunc})

```

go 语言中内置了一些模板函数如下：  

```go 
var builtins = FuncMap{
    "and":      and,
    "call":     call,
    "html":     HTMLEscaper,
    "index":    index,
    "js":       JSEscaper,
    "len":      length,
    "not":      not,
    "or":       or,
    "print":    fmt.Sprint,
    "printf":   fmt.Sprintf,
    "println":  fmt.Sprintln,
    "urlquery": URLQueryEscaper,
}
```

* 例子  

```go 
package main

import (
	"os"
	"text/template"
)

func handleInt(number uint) uint {
	return number + 10
}
func handleString(field string) string {
	return "\"" + field+"\""
}

func main() {
	//结构
	type Student struct {
		Name string
		Age    uint
	}
	type NewStudents struct {
		Students [] Student
	}
	//结构实例
	students := NewStudents{
		Students: [] Student{
			Student{ Name: "Nick", Age:20},
			Student{ Name: "Elaine", Age:19},
		},
	}

	var Text = `
{{ range .Students }}
{{.Name | handleString}} is {{.Age | handleInt}} years old
{{- end }}
`
	tmpl, err := template.New("test").
		Funcs(template.FuncMap{"handleString": handleString, "handleInt": handleInt}).
		Parse(Text)
	if err!=nil {
		panic(err)
	}
	//合成模板,并输出到标准输出中去，student中的具体指，被传入进去
	err = tmpl.Execute(os.Stdout, students)
	if err!=nil {
		panic(err)
	}
}


```