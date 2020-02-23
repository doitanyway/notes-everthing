# gin-web Server框架


为了使用Gin包，我们需要先安装go语言，然后设置Go的工作空间

* 安装go,执行如下命令：  

```bash
go get -u github.com/gin-gonic/gin
```

* 代码中添加如下内容：
```go
import "github.com/gin-gonic/gin"
```

* (Optional) 引入 net/http 依赖. 
```go 
import "net/http"
```

## 快速开始例子

```go 
package main

import "github.com/gin-gonic/gin"

func main() {
	r := gin.Default()
	r.GET("/ping", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "pong",
		})
	})
	r.Run() // listen and serve on 0.0.0.0:8080 (for windows "localhost:8080")
}
```

* [官方地址](https://github.com/gin-gonic/gin)