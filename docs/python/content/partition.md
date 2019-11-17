# 字符串分割-partition/rpartition

```PY 
str_test = "hello word"
# 1.partition 返回三部分，str前，str自身，str后，如下函数返回 ('hell', 'o', ' word')
print(str_test.partition('o'))
# 2.rpartition与partition函数类似，只是在查找函数的时候从后往前找
print(str_test.rpartition('o'))

```