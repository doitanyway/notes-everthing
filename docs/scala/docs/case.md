#  模式匹配


* 匹配内容 

```scala 
package com.nick.study.cases

import scala.util.Random

object CaseDemo1 extends App {

  var arr = Array("Nick","Elaine","Jessica")
  var name = arr(Random.nextInt(arr.length))
  println(name)
  name match {
    case "Nick" =>  println("男人")
    case "Elaine" => println("女人")
    case _ => println("可能是baby")
  }
}

```

* 匹配类型  

```scala 
package com.nick.study.cases

import scala.util.Random

object CaseDemo2 extends App {

  var arr = Array("Nick", 1, 2.0, CaseDemo2)
  //  var name = arr(Random.nextInt(arr.length))
  var name = arr(2)
  println(name)
  name match {
    case x: Int => println("Int:" + x)
    //      可以在前面加一个判断范围
    case x: Double if (x > 2) => println("Double:" + x)
    case x: String => println("String:" + x)
    case CaseDemo2 => {
      println("CaseDemo2")
    }
    case _ => println("啥都不知道")
  }
}

```

* 匹配数组  

```scala 
package com.nick.study.cases

object CaseDemo3 extends App {

  var arr = Array(0,3,5,7)

  arr match {
    case Array(1,2,3,4,x,y) => println("(x,y)" + x+","+y)
    case Array(1,3,5,x) => println("(x)" + x)
    case Array(0,_*) => println("0...")
    case _ => println("啥都不知道")
  }
}
```