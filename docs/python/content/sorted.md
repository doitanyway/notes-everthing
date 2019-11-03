#  高阶函数-sorted

sorted用来排序，默认使用升序


```PY 
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# 排序默认升序
var = sorted([10, 5, -2, 9, -1])
print(var)

# 自定义排序，根据函数abs返回值排序，绝对值
var = sorted([36, 5, -12, 9, -21], key=abs)

# 
from operator import itemgetter
students = [('Bob', 75), ('Adam', 92), ('Bart', 66), ('Lisa', 88)]

# [('Adam', 92), ('Bart', 66), ('Bob', 75), ('Lisa', 88)] ，按名字
print(sorted(students, key=itemgetter(0)))

# [('Bart', 66), ('Bob', 75), ('Lisa', 88), ('Adam', 92)] ，按数字
print(sorted(students, key=lambda t: t[1]))

# [('Adam', 92), ('Lisa', 88), ('Bob', 75), ('Bart', 66)] ，按数字逆序
print(sorted(students, key=itemgetter(1), reverse=True))


```