# 路由简介


## 路由函数 

* ``routers/router.go``路由控制文件，用它来控制路由路径和控制类之间的关系。  

```GO
package routers

import (
	"hello/controllers"
	"github.com/astaxie/beego"
)

func init() {
	//路由指向 URL : http://localhost:8080/  ,MainController.Get 函数
    beego.Router("/", &controllers.MainController{})
    //路由指向 URL : http://localhost:8080/hi  ,MainController.Hi 函数
    beego.Router("/hi",&controllers.MainController{},"get:Hi")
}

```


## 控制类  

* ``controllers/default.go``是默认的控制类文件

```go 
package controllers

import (
	"fmt"
	"github.com/astaxie/beego"
)

type MainController struct {
	beego.Controller
}

func (c *MainController) Get() {
	//c.Data赋值的数据到前端视图上可以访问
	c.Data["Website"] = "beego.me"
	c.Data["Email"] = "astaxie@gmail.com"
	//指定对应的前端视图
	c.TplName = "index.tpl"
}


func (c * MainController) Hi(){
	fmt.Print("hi console.")
	//	这里没有指定前端视图，访问的时候会报错
}
```