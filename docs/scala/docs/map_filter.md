# scala map&filter


```scala
package com.nick.study

object MapTest {
  //  Unit 代表没有返回值
  def main(args: Array[String]): Unit = {

    val arr = Array(1, 2, 3, 4, 5, 6, 7, 8, 9)

    //    每个数字乘以2
    val arr1 = arr.map(x => x * 2)
    for (x <- arr1) print(x + " ")
    println()

    //    过滤保留偶数集合
    val arr2 = arr.filter(x => x % 2 == 0)
    for (x <- arr2) print(x + " ")
    println()
    
    // 求和
    var sum = arr2.reduce((x,y) => x+y)
    println(sum)
  }

}

```