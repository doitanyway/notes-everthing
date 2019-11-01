# 函数  

## 定义使用函数 

```py 
# 声明函数
def my_fun(age):
  if age > 18:
    return 'old'
  else: 
    return 'young'

# 调用函数

print(my_fun(20))
```

## 参数检查 


```PY
def my_fun(age):
    if not isinstance(age, (int, float)):
        raise TypeError('bad operand type')
    if age >= 18:
        return 'old'
    else:
        return 'young'
```

> 使用raise抛出错误

## 返回多个值  

```PY 
import math

def move(x, y, step, angle=0):
    nx = x + step * math.cos(angle)
    ny = y - step * math.sin(angle)
    return nx, ny
```

> 实际返回值是一个tuple类型，调用方法如： 
> x, y = move(100, 100, 60, math.pi / 6)
> r = move(100, 100, 60, math.pi / 6)   (值为： (151.96152422706632, 70.0))