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