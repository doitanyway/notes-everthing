# scala 集合




```scala

package com.nick.study

//  _代表添加包下面的所有类
import scala.collection.mutable._

object ArrayTest {

  def main(args: Array[String]): Unit = {

    //    初始化空的数组
    val a = new Array[String](6)
    a.map(x => print(x + " "))
    println()

    //  含值初始化
    val a1 = Array("a", "hello", "c")
    a1.map(x => print(x + " "))
    println()

    //  可变集合，+ -
    val a2 = new ArrayBuffer[Int]()
    a2 += 3
    a2 += 5
    a2 += 4
    a2 += 5
    println(a2)
    a2 -= 5
    println("1.." + a2)
    a2 -= 5
    println("2.." + a2)
    a2 -= 5
    println("3.." + a2)
    //   加等10
    val a3 = new ArrayBuffer[Int]()
    a3 += 20
    a3 += 30
    a2 ++= a2
    println("4.." + a2)

    //追加数据,第一个参数是角标，后面是需要追加的数据
    a2.insert(0, 2, 1, -1)
    println("5.." + a2)

    //    删除,从角标0开始，删除2个元素
    a2.remove(1, 2)
    println("6.." + a2)


  }

}


```