# scala循环


##  数组

```java
// 包含最后一个数
scala> 1 to 10
res2: scala.collection.immutable.Range.Inclusive = Range(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
// 不包含最后一个数
scala> 1 until 10
res3: scala.collection.immutable.Range = Range(1, 2, 3, 4, 5, 6, 7, 8, 9)
```


## for循环

```scala

package com.nick.study

object ForTest {

  def main(args: Array[String]): Unit = {
    //1. 简单循环
    for (i <- 1 to 10) println(i)

    for (i <- 1 to 10){
      println(i)
    }

    //2.不包含最后一个数字10
    for (i <- 1 until  10) println(i)

    val str ="Nick"
    //3.遍历字符串的字符
    for(c <- str){
      println(c)
    }

    //4.通过下标遍历
    for (i <- 0 until str.length )
      println(str.charAt(i))

    //5.遍历数组
    val arr = Array(1,5,9,10)
    for (x <- arr) println(x)

    //6.通过下表读数组
    for (i <- 0 until arr.length )
      println(arr(i))

    //7.双层循环
    for(i<-1 to 3 ; j<-1 to 3 if i != j)
      print ((10*i+j) + " ")
    println()

    //8.for 推导式，生成一个集合,Vector(10, 20, 30, 40, 50, 60, 70, 80, 90, 100)
    val v = for (i<-1 to 10 ) yield i*10
    println(v)

    //map循环处理，下面2个等效
    println((1 to 10).map(_ * 10))
    println((1 to 10).map(x => x * 10))

    //过滤,计算重组
    val arr1 = 1 to 10
    for(i <- arr1 if i %2==0 )yield i*100

    //过滤,计算重组，其他方法
    arr1.filter(m => m%2 == 0).map(_*10)
  }

}


```