# scala方法


```scala
package com.nick.study

object FunctionTest {
  //  Unit 代表没有返回值
  def main(args: Array[String]): Unit = {

    println(add(12, 1))
    //    调用可以不使用括号
    sayHello
    sayHello1
  }

  //  无参数返回函数
  def sayHello(): Unit = {
    println("hello")
  }

  //自动推断返回
  def sayHello2() = {
    println("hello1")
  }

  //无返回值
  def sayHello1() {
    println("hello1")
  }

  //  带返回值
  def add(x: Int, y: Int): Int = {
    return x + y
  }

  //返回值推断类型，一般方法可以不写返回值，但是递归方法一定要写返回值类型
  def add1(x: Int, y: Int) {
    return x + y
  }
}

```
