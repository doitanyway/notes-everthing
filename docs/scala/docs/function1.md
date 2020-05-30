# scala函数

函数在scala中是一等公民，函数可以作为参数传入到方法里面


## 简单定义函数

```bash 
# scala命令行执行
# 简单定义一个函数
scala> (x: Int , y: Int) => x+y
res0: (Int, Int) => Int = <function2>
# 给函数取名，该函数的完整写法为： val f1 = (x: Int , y: Int) => Int ={(x,y) => x+y}
scala> val f1 = (x: Int , y: Int) => x+y
f1: (Int, Int) => Int = <function2>
```
