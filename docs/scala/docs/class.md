# scala类

## 简单类的定义

```scala
package com.nick.study.student

class Student {
  //  不可以修改值
  val id: Int = 10
  //  私有属性，只有伴生对象和类的内部能够访问
  private val name: String = "Nick"
  //  可以修改值
  var age = 10
  //  私有属性，只有类的内部能够访问
  private[this] val password: String = "Nick"

}

//伴生对象，和类名字相同，写在同一个文件之中
object Student {
  def main(args: Array[String]): Unit = {
    val s = new Student
    println(s.id)
    println(s.age)
    s.age = 100
    println(s.age)


  }
}
```

## 构造函数


* 主构造器和辅助构造器

```scala
package com.nick.study.student

//每个类都有主构造器，主构造器的参数直接放类名后面，与类在一起
//构造函数中的变量直接成了类的成员属性
class Person(val id: Long, var name: String = "nick", var age: Int) {
  //如果在构造器中没有用var 或者val修饰相当于private[this]修饰的变量
  //主构造器执行类定义中的所有语句

  var gender: String = _
  //辅助构造器，辅助构造器不能加修饰符var val
  def this(id: Long, name: String , age: Int, gender: String) {
    //    辅助构造器必须先调主构造器
    this(id, name, age)
    this.gender = gender
  }

  def this( gender: String) {
    //    辅助构造器必须先调主构造器
    this(1, "nick", 12)
    this.gender = gender
  }
}

object Person {

  def main(args: Array[String]): Unit = {
    val p = new Person(10L, "elaine", 20)
    //id可以访问，但是不能修改
    println(p.id)
    p.name = "Jessica"
    println(p.name)
  }
}
```

* 私有构造器

```scala
package com.nick.study.student

//如下加private关键字，为私有构造器，智能在伴生对象中使用
class Person1 private (val id: Long, var name: String = "nick", var age: Int) {
  println("执行主构造器")
}


object  Person1{
  def main(args: Array[String]): Unit = {
    val p = new  Person1(1,"nick",12)
  }
}
```

* 设置类只能在包内访问

```
package com.nick.study.test1
private[test1] class Teacher {
}
```