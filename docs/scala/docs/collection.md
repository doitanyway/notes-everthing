# scala 集合



## 简单集合的用法

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


## mutable-可变 & imutable不可变集合


```scala
package com.nick.study

//  _代表添加包下面的所有类
import scala.collection.mutable._
//mutable  是可变的集合
//imutable 是不可变的


object ArrayTest {

  def main(args: Array[String]): Unit = {

//    1.MAP
    //    创建一个不可变的hash map
    val im1 = scala.collection.immutable.HashMap[String, Int]()
    println("im1:" + im1)
    //    创建一个不可变的hash map ,并初始化一些值
    val im2 = scala.collection.immutable.HashMap[String, Int]("a" -> 1, "b" -> 2)
    println("im2:" + im2)
    //    im2.put("c",10)  //非法，没有该方法不能该表值

    //
    val m3 = scala.collection.mutable.HashMap[String, Int]()
    m3.put("c", 20)
    println("m3:" + m3)
    m3 += ("c" ->2)
    println("+m3:" + m3)
    m3 -= "c"
    println("-m3:" + m3)

//2. List
    val list = List(1,2,3,4,5)
//    list(0) =1  //不能修改

    val listBuffer = ListBuffer(1,2,3,4,5)
    listBuffer(0) = 30
    println(listBuffer)
    listBuffer += 20
    println(listBuffer)
    println("+"+listBuffer)
    listBuffer += (20,30)
    println("++"+listBuffer)


//   3.Set,不重复集合
    val set = Set(1,2,3,4)
    println("1.+"+set)
    set += 6
    println("2.+"+set)
    set +=(7,7)
    println("3."+set)


  }

}

```
