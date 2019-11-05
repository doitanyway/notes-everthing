# 偏函数  
为一个函数创建默认值来定义一个偏函数。 


```py
# 定义一个偏函数
import functools
int2 = functools.partial(int, base=16)
# 使用该函数
print(int2('ff'))
print(int2('f'))
```