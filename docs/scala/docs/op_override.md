# scala操作符重载


```bash
1+2
# 等效如下的函数
1.+(2)

1 to 10
# 等效如下函数
1.to(10)


# 重载+运算符
scala> def +(x: Int , y: Int) : Int = {x+y}
$plus: (x: Int, y: Int)Int

scala> $plus(1,1)
res2: Int = 2

```


* 如下图所示是scala中Int类的代码，可看到重载了很多运算符。


```scala
package scala
final abstract class Int() extends scala.AnyVal {
  def toByte : scala.Byte
  def toShort : scala.Short
  def toChar : scala.Char
  def toInt : scala.Int
  def toLong : scala.Long
  def toFloat : scala.Float
  def toDouble : scala.Double
  def unary_~ : scala.Int
  def unary_+ : scala.Int
  def unary_- : scala.Int
  def +(x : scala.Predef.String) : scala.Predef.String
  def <<(x : scala.Int) : scala.Int
  def <<(x : scala.Long) : scala.Int
  def >>>(x : scala.Int) : scala.Int
  def >>>(x : scala.Long) : scala.Int
  def >>(x : scala.Int) : scala.Int
  def >>(x : scala.Long) : scala.Int
  def ==(x : scala.Byte) : scala.Boolean
  def ==(x : scala.Short) : scala.Boolean
  def ==(x : scala.Char) : scala.Boolean
  def ==(x : scala.Int) : scala.Boolean
  def ==(x : scala.Long) : scala.Boolean
  def ==(x : scala.Float) : scala.Boolean
  def ==(x : scala.Double) : scala.Boolean
  def !=(x : scala.Byte) : scala.Boolean
  def !=(x : scala.Short) : scala.Boolean
  def !=(x : scala.Char) : scala.Boolean
  def !=(x : scala.Int) : scala.Boolean
  def !=(x : scala.Long) : scala.Boolean
  def !=(x : scala.Float) : scala.Boolean
  def !=(x : scala.Double) : scala.Boolean
  def <(x : scala.Byte) : scala.Boolean
  def <(x : scala.Short) : scala.Boolean
  def <(x : scala.Char) : scala.Boolean
  def <(x : scala.Int) : scala.Boolean
  def <(x : scala.Long) : scala.Boolean
  def <(x : scala.Float) : scala.Boolean
  def <(x : scala.Double) : scala.Boolean
  def <=(x : scala.Byte) : scala.Boolean
  def <=(x : scala.Short) : scala.Boolean
  def <=(x : scala.Char) : scala.Boolean
  def <=(x : scala.Int) : scala.Boolean
  def <=(x : scala.Long) : scala.Boolean
  def <=(x : scala.Float) : scala.Boolean
  def <=(x : scala.Double) : scala.Boolean
  def >(x : scala.Byte) : scala.Boolean
  def >(x : scala.Short) : scala.Boolean
  def >(x : scala.Char) : scala.Boolean
  def >(x : scala.Int) : scala.Boolean
  def >(x : scala.Long) : scala.Boolean
  def >(x : scala.Float) : scala.Boolean
  def >(x : scala.Double) : scala.Boolean
  def >=(x : scala.Byte) : scala.Boolean
  def >=(x : scala.Short) : scala.Boolean
  def >=(x : scala.Char) : scala.Boolean
  def >=(x : scala.Int) : scala.Boolean
  def >=(x : scala.Long) : scala.Boolean
  def >=(x : scala.Float) : scala.Boolean
  def >=(x : scala.Double) : scala.Boolean
  def |(x : scala.Byte) : scala.Int
  def |(x : scala.Short) : scala.Int
  def |(x : scala.Char) : scala.Int
  def |(x : scala.Int) : scala.Int
  def |(x : scala.Long) : scala.Long
  def &(x : scala.Byte) : scala.Int
  def &(x : scala.Short) : scala.Int
  def &(x : scala.Char) : scala.Int
  def &(x : scala.Int) : scala.Int
  def &(x : scala.Long) : scala.Long
  def ^(x : scala.Byte) : scala.Int
  def ^(x : scala.Short) : scala.Int
  def ^(x : scala.Char) : scala.Int
  def ^(x : scala.Int) : scala.Int
  def ^(x : scala.Long) : scala.Long
  def +(x : scala.Byte) : scala.Int
  def +(x : scala.Short) : scala.Int
  def +(x : scala.Char) : scala.Int
  def +(x : scala.Int) : scala.Int
  def +(x : scala.Long) : scala.Long
  def +(x : scala.Float) : scala.Float
  def +(x : scala.Double) : scala.Double
  def -(x : scala.Byte) : scala.Int
  def -(x : scala.Short) : scala.Int
  def -(x : scala.Char) : scala.Int
  def -(x : scala.Int) : scala.Int
  def -(x : scala.Long) : scala.Long
  def -(x : scala.Float) : scala.Float
  def -(x : scala.Double) : scala.Double
  def *(x : scala.Byte) : scala.Int
  def *(x : scala.Short) : scala.Int
  def *(x : scala.Char) : scala.Int
  def *(x : scala.Int) : scala.Int
  def *(x : scala.Long) : scala.Long
  def *(x : scala.Float) : scala.Float
  def *(x : scala.Double) : scala.Double
  def /(x : scala.Byte) : scala.Int
  def /(x : scala.Short) : scala.Int
  def /(x : scala.Char) : scala.Int
  def /(x : scala.Int) : scala.Int
  def /(x : scala.Long) : scala.Long
  def /(x : scala.Float) : scala.Float
  def /(x : scala.Double) : scala.Double
  def %(x : scala.Byte) : scala.Int
  def %(x : scala.Short) : scala.Int
  def %(x : scala.Char) : scala.Int
  def %(x : scala.Int) : scala.Int
  def %(x : scala.Long) : scala.Long
  def %(x : scala.Float) : scala.Float
  def %(x : scala.Double) : scala.Double
  override def getClass() : scala.Predef.Class[scala.Int] = { /* compiled code */ }
}
object Int extends scala.AnyRef with scala.AnyValCompanion {
  final val MinValue = -2147483648
  final val MaxValue = 2147483647
  def box(x : scala.Int) : java.lang.Integer = { /* compiled code */ }
  def unbox(x : java.lang.Object) : scala.Int = { /* compiled code */ }
  override def toString() : java.lang.String = { /* compiled code */ }
  implicit def int2long(x : scala.Int) : scala.Long = { /* compiled code */ }
  implicit def int2float(x : scala.Int) : scala.Float = { /* compiled code */ }
  implicit def int2double(x : scala.Int) : scala.Double = { /* compiled code */ }
}

```