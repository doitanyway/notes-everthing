# hello word

## 简介

本文讲解如何编写第一个scala程序

## 编写scala代码 

* 编写文件``hello.scala``

```scala
object HelloScala{
  def main(args: Array[String]){
    println("hello scala")
  }
}
```


* 编译执行  

```bash 
# 编译
scalac hello.scala
# 执行
scala HelloScala
```

