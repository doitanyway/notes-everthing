# 列表生成式

列表生成器用来创建一些有规律的列表。

```py
# 生成 [1, 2, 3, 4, 5, 6, 7, 8, 9,10]
var = list(range(1,11))
print(var)

# 生成[1x1, 2x2, 3x3, ..., 10x10]
var = [x * x for x in range(1, 11)]
print(var)

# 加上if 判断
var = [x * x for x in range(1, 11) if x % 2 == 0]
print(var)

# 两层循环，可以生成全排列：
var = [m + n for m in 'ABC' for n in 'XYZ']
print(var)

# 两层以上循环，尽量别用了吧，太复杂，效率也低
```

