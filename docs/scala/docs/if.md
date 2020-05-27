# scala条件



```scala
package com.nick.study

object ConditionTest {
  def main(args: Array[String]): Unit = {

    //简单条件
    val x = 20
    val y: String = if(x > 20 ) "old" else "young"
    println("y="+y)

    //条件换行,注意条件中的返回值没有return
    val m = if (x>10){
      println("larger than 10")
      10
    }else{
      println("smaller than 10 sor equal to  10 ")
      20
    }
    println("m="+m)

    //不返回
    if (x>10){
      println("bigger than 10")
    }else{
      println("smaller or equal to 10")
    }
    //条件返回不同类型
    val w = if (x>10)  100 else "ERROR"
    println("ANY return : w="+w+",type")

    //没有else   返回 ()
    val z = if(x>20) 10
    println("No else: z="+ z)

    // else if用法
    val zz = if (x <0 ) 0
    else if (x >  10)  100
    else 50
    println(zz)
  }
}

```


> 在scala{}包含的一系列表达式叫块表达式。