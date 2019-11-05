# 装饰器 
我们期望在函数前后执行某一任务，但是又不期望改变该函数，则可以使用装饰器。 
装饰器实际上为一个返回函数的高阶函数

```py 
def log(func):
  def wrapper(*args,**kw):
    print('call %s()' % func.__name__)
    return func(*args,**kw)
  return wrapper


@log
def now():
    print('2019-11-04')

now()
```