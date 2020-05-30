# 单机word count 


```scala

package com.nick.study

object WordCount {
  def main(args: Array[String]): Unit = {
    var lines = Array("hello this is a new word", "hello this is not a good idea", "you you can do it ")
    //    切分打平
    val words: Array[String] = lines.flatMap(_.split(" "))
    //    将单词放在一个元组中
    val wordAndOne: Array[(String, Int)] = words.map((_, 1))
    //    分组
    val groupd: Map[String, Array[(String, Int)]] = wordAndOne.groupBy(_._1)
    println("groupd="+groupd)
    //  求value长度
    val wordCounts: Map[String, Int] = groupd.mapValues(_.length)
    //    排序
    val result: List[(String, Int)] = wordCounts.toList.sortBy(_._2).reverse
    //    输出结果
    println(result)

  }
}

```