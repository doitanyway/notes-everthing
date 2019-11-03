
# 数据处理函数-reduce

```py 

# reduce用法,用来求和,reduce(f, [x1, x2, x3, x4]) = f(f(f(x1, x2), x3), x4)
from functools import reduce
def add(a,b):
  return a+b

r = reduce(add, [1, 2, 3, 4, 5])
print(r)
```