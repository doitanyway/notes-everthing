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