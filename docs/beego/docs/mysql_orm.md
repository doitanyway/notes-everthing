# 接入mysql-使用orm

## 说明 

本练习接上一章，[接入mysql-直接用SQL取数](./mysql.md)本节将使用orm读取数据库数据。


## 详细说明


* 安装依赖包 

```bash 
go get github.com/astaxie/beego/orm
```


* 新建一个模型文件``models/testorm.go``  

```go 
package models

import (
	"fmt"

	"github.com/astaxie/beego/orm"
	_"github.com/go-sql-driver/mysql"
)

type User struct {
	Id int
	Name string
	Sex int8
}

func init()  {
	// 注册一个default database,并且设置最大连接数是30
	orm.RegisterDataBase("default","mysql",
		"root:123456@tcp(127.0.0.1:3306)/db1?charset=utf8",30)
	// 注册Model
	orm.RegisterModel(new(User))
	// 自动建表
	orm.RunSyncdb("default",false,true)
}

func PrintUserByORM()  {
	o := orm.NewOrm()
	user := User{Id: 3}
	o.Read(&user)
	fmt.Println(user)
}
```

* 在控制类中使用``controllers/default.go``  

```go 
package models

import (
	"fmt"

	"github.com/astaxie/beego/orm"
	_"github.com/go-sql-driver/mysql"
)

type User struct {
	Id int
	Name string
	Sex int8
}

func init()  {
	
	orm.RegisterDataBase("default","mysql",
		"root:123456@tcp(127.0.0.1:3306)/db1?charset=utf8",30)
	orm.RegisterModel(new(User))
}

func PrintUserByORM()  {
	o := orm.NewOrm()
	user := User{Id: 3}
	o.Read(&user)
	fmt.Println(user)
}

```

* 在控制类中使用``controllers/default.go``  

```go 
func (c * MainController) Hi(){
	fmt.Println("hi console.")

	//models.PrintUsers()
	models.PrintUserByORM()
	//指定对应的前端视图
	c.TplName = "index.tpl"
}
```



## 验证

* 启动执行该程序，访问页面``http://localhost:8080/hi``

```bash 
bee run 
```

![](./assets/2020-01-23-15-11-09.png)



## 补充说明 

orm的其他用法。

```go 

func testORM()  {
	//新建一个ORM对象，并且选中数据库
	o := orm.NewOrm()
	o.Using("default")

	//插入一个数据
	user := User{Id: 20, Name:"Nick1", Sex:1}
	o.Insert(&user)


	//更新一个数据
	user.Sex = 0
	o.Update(&user)

	//读name是Nick1的用户
	user.Name = "Nick1"
	o.Read(&user,"name")

	//删除ID为1的用户
	o.Delete(&User{Id: 1})

	//原生支持，待验证
	ids := []int{1,2,3}
	users := o.Raw("SELECT name FROM user WHERE id IN (?,?,?)",ids)

	println(users)

}
```