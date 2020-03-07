# 检测编码方式

## 前言

获取html 页面，并且检测它的编码方式，然后再转码成为utf8 

## 代码 

```go 
package main
// go get golang.org/x/text
// go get golang.org/x/net/html
// encoding determine for html page , eg: gbk gb2312 GB18030

import (
	"bufio"
	"fmt"
	"golang.org/x/net/html/charset"
	"golang.org/x/text/encoding"
	"golang.org/x/text/encoding/unicode"
	"golang.org/x/text/transform"
	"io/ioutil"
	"net/http"
)

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
	reader := transform.NewReader(bufReader, encoding.NewDecoder())
	contents, err := ioutil.ReadAll(reader)
	if err != nil {
		panic(err)
	}

	//fmt.Println(contents)
	fmt.Printf("%s",contents)
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