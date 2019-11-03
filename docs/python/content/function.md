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

## 默认参数

```PY 
def power(x, n=2):
    s = 1
    while n > 0:
        n = n - 1
        s = s * x
    return s
```

> 如上函数，调用时可以只写x的值。poer(10)

## 可变参数

```PY 
def calc(*numbers):
    sum = 0
    for n in numbers:
        sum = sum + n * n
    return sum
# 结果为5
calc(1, 2)
# 结果为0
calc()
```

## 关键字参数  

```PY 
def person(name, age, **kw):
    print('name:', name, 'age:', age, 'other:', kw)

person('Michael', 30)
# name: Michael age: 30 other: {}

person('Bob', 35, city='Beijing')
# name: Bob age: 35 other: {'city': 'Beijing'}

person('Adam', 45, gender='M', job='Engineer')
# name: Adam age: 45 other: {'gender': 'M', 'job': 'Engineer'}

extra = {'city': 'Beijing', 'job': 'Engineer'}
person('Jack', 24, **extra)
# name: Jack age: 24 other: {'city': 'Beijing', 'job': 'Engineer'}

```