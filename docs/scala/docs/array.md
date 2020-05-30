# scala 数组


```scala 
package com.nick.study

//  _代表添加包下面的所有类
import scala.collection.mutable._
//mutable  是可变的集合
//imutable 是不可变的


object ArrayTest {

  def main(args: Array[String]): Unit = {
    val arr = Array(1, 4, 2, 6, 3, 5, 7, 8)
    println("arr.sum=" + arr.sum)
    println("arr.max=" + arr.max)
    println("arr.min=" + arr.min)
    println("arr.average=" + arr.sum / arr.length)

    arr.sorted.map(x => print(x + " "))
    println()

    arr.sorted.reverse.map(x => print(x + " "))
    println()


//    第一个参数大于第二个参数，降序
    arr.sortWith(_ > _).map(x => print(x + " "))
    println()
//    降序的完整写法
    arr.sortWith((x,y) => x >y)

//改变排序规则 ，按字符串排序
    val arr1 = Array(1,3,11,22,13,15)
    arr1.sortBy(x => x.toString).map(x => print(x+" "))
    println()
  }

}

```