# 可选

Option 为了避免获得值为空程序报错，需要做一些错误处理，例子见如下程序：

```scala
object MapTest {
  def main(args: Array[String]): Unit = {
    val map = Map("a" -> 1, "b" -> 2)

    val maybeInt: Option[Int] = map.get("w")
    if (maybeInt.isEmpty){
      println("w is empty")
    }

    //    正常取到了值则返回值，否则返回-1
    var r = map.getOrElse("a", -1)
    println("r:"+r)
  }

}
```