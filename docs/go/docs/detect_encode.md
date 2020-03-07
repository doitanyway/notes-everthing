# 检测编码方式

## 前言

获取html 页面，并且检测它的编码方式，然后再转码成为utf8 

## 代码 

```go 
// 安装如下Module
// go get golang.org/x/text
// go get golang.org/x/net/html
func main() {
	resp,err := http.Get("http://www.zhenai.com/zhenghun")
	if err != nil{
		panic(err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		fmt.Println("ERROR: status code",resp.StatusCode)
		return
	}
	e := determineEncoding(resp.Body)
	//转换成为utf8
	utf8Reader := transform.NewReader(resp.Body, e.NewDecoder())

	all, err := ioutil.ReadAll(utf8Reader)
	if err != nil{
		panic(err)
	}
	fmt.Printf("%s\n",all)
}

// 检查字符串的编码方式
func determineEncoding( r io.Reader) encoding.Encoding {
	bytes, err := bufio.NewReader(r).Peek(1024)
	if err != nil{
		panic(err)
	}
	e, _, _ := charset.DetermineEncoding(bytes, "")
	return e
}

```