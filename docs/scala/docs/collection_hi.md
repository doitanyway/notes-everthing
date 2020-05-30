# scala 高级用法

```scala
package com.nick.study

object ListTest {
  def main(args: Array[String]): Unit = {

    //    创建一个List
    val list0 = List(1, 9, 8, 7, 2, 0, 1, 2, 3)
    //每个数乘以2得到一个新的集合
    val list1 = list0.map(x => x * 2)
    //    过滤剩下偶数
    val list2 = list0.filter(x => x % 2 == 0)
    // 排序
    val list3 = list0.sorted //升序
    val list4 = list0.sortBy(x => x)
    val list5 = list0.sortWith((x, y) => x < y)//按升序排序
    val list51 = list0.sortWith((x, y) => x.toString < y.toString)//按字典升序排序

    //    反转排序
    val list6 = list3.reverse
    //    list0的元素4个一组,类型为 Iterator[List[Int]]
    val it = list0.grouped(4)
    //    将Iterator转换成List
    val list7 = it.toList
    //    将多个List压扁成为一个List
    val list8 = list7.flatten

    val array = Array("a b c","d e f", "h i w")

    var sum = list0.reduce((x,y) => x+y)
    println(sum)
    list0.reduceLeft((x,y) => x+y)

    //有一个初始值
    println(list0.fold(100)(_+_))
    println(list0.foldLeft(100)(_+_))

    //聚合,如下aggregate方法初始值0，
    val arr = List(List(1,2,3),List(4,5,6),List(2),List(0))
    val result = arr.aggregate(0)(_+_.sum,_+_)      //等效于如下
    arr.aggregate(0)((x,y) => x+y.sum, (m,n) => m+n)  //x代表初始值, y.sum 代表list的sum,  (m,n) => m+n 相当于一个reduce操作


    val l1 = List(5,6,4,8)
    val l2 = List(1,2,3,4)
    //    求并集  List(5, 6, 4, 8, 1, 2, 3, 4), 不去重复,如果是set类型才去重复,也可以写成 :  l1 union l2
    var r1 = l1.union(l2)

    //    求交集合,2个都有的, List(4)  也可以写成 :   l1 intersect  l2
    val r2 = l1.intersect(l2)
    //    求差集  List(5, 6, 8)
    val r3 = l1.diff(l2)
    println(r3)

    //    创建一个List
    val list0 = List(1, 9, 8, 7, 2, 0, 1, 2, 3)
    // list0 变成一个并行集合，然后再计算
    list0.par.fold(0)(_+_)

  }

}

```
