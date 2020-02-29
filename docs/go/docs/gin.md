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


* jin和zap混合使用  

```go 
package main

import (
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
	"time"
)

func main() {
	r := gin.Default()
	logger, err := zap.NewProduction()
	if err!= nil{
		panic(err)
	}
	r.Use(func(c *gin.Context) {
		s := time.Now()
		c.Next()
		logger.Info("incoming request",zap.String("path",c.Request.URL.Path),
				zap.Int("status",c.Writer.Status()),
				zap.Duration("elapsed",time.Now().Sub(s)))
	})
	r.GET("/ping", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "pong",
		})
	})
	r.GET("/hello", func(c *gin.Context) {
		c.String(200, "hello")
	})
	r.Run() // listen and serve on 0.0.0.0:8080 (for windows "localhost:8080")
}
```

* header 中添加元素  
```go 
package main

import (
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
	"math/rand"
	"time"
)

func main() {
	r := gin.Default()
	logger, err := zap.NewProduction()
	if err!= nil{
		panic(err)
	}
	r.Use(func(c *gin.Context) {
		s := time.Now()
		c.Next()
		logger.Info("incoming request",zap.String("path",c.Request.URL.Path),
				zap.Int("status",c.Writer.Status()),
				zap.Duration("elapsed",time.Now().Sub(s)))
	}, func(c *gin.Context) {
		c.Set("requestId",rand.Int())
		c.Next()
	})
	r.GET("/ping", func(c *gin.Context) {
		h := gin.H{
			"message": "pong",
		}
		if rid, exists := c.Get("requestId"); exists{
			h["requestId"] =  rid
		}
		c.JSON(200, h)
	})
	r.GET("/hello", func(c *gin.Context) {
		c.String(200, "hello")
	})
	r.Run() // listen and serve on 0.0.0.0:8080 (for windows "localhost:8080")
}
```

* [官方地址](https://github.com/gin-gonic/gin)