# 继承

## 简介

知识点：  
* 继承可以继承抽象类，和trait，介绍基本用法；
* extends只集成trait的语法注意点；


## 代码例子

* 抽象类   
```scala
package com.nick.study.extends1


//一个抽象类，一个类只能继承一个抽象类
abstract class Animal {
//  有默认的实现，子类可以不实现，也可以重新
  def run :Unit ={
    println("跑起来")
  }

  def aaa():String
}

```

* trait   

```scala
package com.nick.study.extends1

//一个接口，一个类可以继承多个trait
trait Eatable {

  def eat():Unit
}

```

```scala
package com.nick.study.extends1

//一个接口，一个类可以继承多个trait
trait Flyable {

  def fly():Unit
}

```


* 实现  

```scala 
package com.nick.study.extends1

//集成一个抽象类，实现多个trait
class Monky extends Animal with Flyable with Eatable {
  //  如果要重写非必须的方法run ,必须要加override关键字
//  实现aaa 可以不加override，不过笔者认为写上最好，可读性最好
  def aaa(): String = {
    ""
  }
  override def fly(): Unit = {
    println("到处飞")
  }

  override def eat(): Unit = {
    println("吃西瓜")
  }

  override def run: Unit = {
      println("猴子走啊走")
  }
}

object Monky {
  def main(args: Array[String]): Unit = {
//    new Monky可以使用父类来接收
    var a: Animal = new Monky
    a.run
  }
}
```


*  全部继承trait的语法：  

```scala 
package com.nick.study.extends1

//如果集成trait出现在第一个，则需要使用extends关键字
class Pig extends Eatable  with Flyable {
  override def fly(): Unit = ???

  override def eat(): Unit = {
    println("吃糠")
  }
}

```


* 动态继承，scala支持动态继承，换句话说，在实例化类的时候继承。
