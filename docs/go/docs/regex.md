# go语言正则表达式

## 简介

正则表达式(regexp)通常用来做字符串匹配和查找，对程序的简化会有很大的帮助。

## 简单demo  

```go 
const text = `My email is qiujiahong@163.com@abc.com
email1 is abc@163.com  email ddd@16q.com
ww  hhhhh@176.com  abc@abc.def.com
`
func main() {
	//简单的匹配邮箱
	//[a-zA-Z0-9]  匹配a-z或者A-Z或者0-9的字符串
	//.+匹配1个或者多个字符
	//.*匹配0个或者多个字符
	//re := regexp.MustCompile(`[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z0-9]+`)
	//修复邮箱域名为二级域名的时候出错如： abc@abc.def.com,
	re := regexp.MustCompile(`[a-zA-Z0-9]+@[a-zA-Z0-9.]+\.[a-zA-Z0-9]+`)
	//匹配一个字符
	fmt.Println("FindString:",re.FindString(text))
	//匹配多个字符串
	fmt.Println("FindAllString:",re.FindAllString(text,-1))
}
```

## 匹配子内容  

如：匹配邮箱并且把邮箱里面的用户名、域名、尾缀都提取出来，如``nick@qq.com`` 提取出 ``nick@qq.com 和 nick、qq以及com``

```go  
const text = `My email is qiujiahong@163.com@abc.com
email1 is abc@163.com  email ddd@16q.com
ww  hhhhh@176.com  abc@abc.def.com
`
func main() {
	re := regexp.MustCompile(`([a-zA-Z0-9]+)@([a-zA-Z0-9.]+)(\.[a-zA-Z0-9]+)`)
	//匹配多个字符串
	match := re.FindAllStringSubmatch(text, -1)
	for _,m := range  match{
		fmt.Println(m)
	}
}
```

* 打印结果如下： 

```bash 
[qiujiahong@163.com qiujiahong 163 .com]
[abc@163.com abc 163 .com]
[ddd@16q.com ddd 16q .com]
[hhhhh@176.com hhhhh 176 .com]
[abc@abc.def.com abc abc.def .com]
```

## 抓取城市列表  

```go 
package main

import (
	"bufio"
	"fmt"
	"golang.org/x/net/html/charset"
	"golang.org/x/text/encoding"
	"golang.org/x/text/encoding/unicode"
	"golang.org/x/text/transform"
	"io/ioutil"
	"net/http"
	"regexp"
)

// go get golang.org/x/text
// go get golang.org/x/net/html
// encoding determine for html page , eg: gbk gb2312 GB18030

func main() {
	resp, err := http.Get( "http://www.zhenai.com/zhenghun")
	if err != nil {
		panic(err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		fmt.Println("ERROR: status code", resp.StatusCode)
		return
	}

	// 转换编码格式
	bufReader := bufio.NewReader(resp.Body)
	encoding := determineEncoding(bufReader)
	fmt.Println("encoding:",encoding)
	reader := transform.NewReader(bufReader, encoding.NewDecoder())
	contents, err := ioutil.ReadAll(reader)
	if err != nil {
		panic(err)
	}
	printCityList(contents)
}

func printCityList(contents []byte) [][] byte {
	re := regexp.MustCompile(`<a href="http://www.zhenai.com/zhenghun/[0-9a-z]+"[^>]*>[^<]+</a>`)
	all := re.FindAll(contents, -1)
	for _,m := range all{
		fmt.Printf("%s\n",m)
	}
	return all
}

// 获取当前页面的编码格式
func determineEncoding(r *bufio.Reader) encoding.Encoding {
	bytes, err := r.Peek(1024)
	if err != nil {
		// 如果没有获取到编码格式，则返回默认UTF-8编码格式
		return unicode.UTF8
	}
	e, _, _ := charset.DetermineEncoding(bytes, "")
	return e
}
```


* 获取城市列表放在数组内  

```go 
package main

import (
	"bufio"
	"fmt"
	"golang.org/x/net/html/charset"
	"golang.org/x/text/encoding"
	"golang.org/x/text/encoding/unicode"
	"golang.org/x/text/transform"
	"io/ioutil"
	"net/http"
	"regexp"
)

// go get golang.org/x/text
// go get golang.org/x/net/html
// encoding determine for html page , eg: gbk gb2312 GB18030
func main() {
	resp, err := http.Get( "http://www.zhenai.com/zhenghun")
	if err != nil {
		panic(err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		fmt.Println("ERROR: status code", resp.StatusCode)
		return
	}

	// 转换编码格式
	bufReader := bufio.NewReader(resp.Body)
	encoding := determineEncoding(bufReader)
	fmt.Println("encoding:",encoding)
	reader := transform.NewReader(bufReader, encoding.NewDecoder())
	contents, err := ioutil.ReadAll(reader)
	if err != nil {
		panic(err)
	}
	printCityList(contents)
}

func printCityList(contents []byte) [][][] byte {
	re := regexp.MustCompile(`<a href="(http://www.zhenai.com/zhenghun/[0-9a-z]+)"[^>]*>([^<]+)</a>`)
	all := re.FindAllSubmatch(contents, -1)
	for _,m := range all{
		//fmt.Printf("%s\n",m)
		fmt.Printf("city: %6s , url: %s \n", m[2],m[1])
	}
	fmt.Println("found:",len(all))
	return all
}

// 获取当前页面的编码格式
func determineEncoding(r *bufio.Reader) encoding.Encoding {
	bytes, err := r.Peek(1024)
	if err != nil {
		// 如果没有获取到编码格式，则返回默认UTF-8编码格式
		return unicode.UTF8
	}
	e, _, _ := charset.DetermineEncoding(bytes, "")
	return e
}
```