# set  

set和dist类似，不同的是，set的key值不可以重复，重复的值会被覆盖掉。


```py
s = set([1, 1, 2, 2, 3, 3])
print(s)
# 输出：{1, 2, 3}

# 添加
s.add(5)
print(s)

# 删除
s.remove(2)
print(s)

# 数学与 或


s1 = set([1, 2, 3])
s2 = set([2, 3, 4])
print(s1 & s2) # {2, 3}
print(s1 | s2) # {2, 3}

```