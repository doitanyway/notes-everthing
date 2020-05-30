# scala对象

## 对象

scala对象使用object修饰,对象是静态的，所以如果想在scala中实现单例模式，直接使用对象即可,语法如下：

```scala
object TestApp  {s
}
```

## 对象的继承 

对象的继承使用extends关键字，如下例：

```scala 
package com.nick.study.test1

//继承
object TestApp extends App {

  println("run ")
}

```

## 对象的apply方法

apply 方法在对象被引用的时候调用，引用时传递的参数个数和类型，决定了具体调用的apply方法是哪一个。

```scala
package com.nick.study.test1

object ApplyTest {
  //
  def apply(str: String): Unit = {
    println(str)
  }

  def main(args: Array[String]): Unit = {
    //    这样引用返回对象
    val m1 = ApplyTest
    println("m1:" + m1)
    //    对象引用的时候会去寻找与该应用相同的apply方法初始化对象,m等于apply方法的返回值
    val m2 = ApplyTest("nick")
    //    apply方法的返回值
    println("m2:" + m2)
  }

}
```


