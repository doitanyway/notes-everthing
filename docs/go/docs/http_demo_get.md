# http client - get 


## 简单例子

```go 
package main

import (
	"fmt"
	"net/http"
	"net/http/httputil"
)

func main() {
	resp , err := http.Get("http://www.baidu.com")
	if err != nil{
		panic(err)
	}
	defer resp.Body.Close()

	s, err := httputil.DumpResponse(resp, true)
	if err != nil{
		panic(err)
	}
	fmt.Printf("%s\n",s)
}

```

## 添加头 

```go 
package main

import (
	"fmt"
	"net/http"
	"net/http/httputil"
)

func main() {
	request, err := http.NewRequest(http.MethodGet, "http://www.baidu.com",nil)
	//添加一个header
	request.Header.Add("name","nick")
	resp, err := http.DefaultClient.Do(request)
	if err != nil{
		panic(err)
	}
	defer resp.Body.Close()

	s, err := httputil.DumpResponse(resp, true)
	if err != nil{
		panic(err)
	}
	fmt.Printf("%s\n",s)
}

```