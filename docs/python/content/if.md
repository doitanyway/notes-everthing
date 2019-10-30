# 条件

## 格式

```
if <条件判断1>:
    <执行1>
elif <条件判断2>:
    <执行2>
elif <条件判断3>:
    <执行3>
else:
    <执行4>
```


## 例

```PY

# 简单IF
age = 20
if age >= 18:
    print('your age is', age)

# if else 
age = 3
if age >= 18:
    print('your age is', age)
else:
    print('your age is', age)


# elif
age = 20
if age >= 6:
    print('teenager')
elif age >= 18:
    print('adult')
else:
    print('kid')
```