# 类

```py 
# class 类名（父类名）
class Student(object):
# 构造函数 self 固定
    def __init__(self, name, score):
        self.name = name
        self.score = score
# self固定
    def get_grade(self):
        if self.score >= 90:
            return 'A'
        elif self.score >= 60:
            return 'B'
        else:
            return 'C'
# 实例
lisa = Student('Lisa', 99)
bart = Student('Bart', 59)
# 方法调用
print(lisa.name, lisa.get_grade())
print(bart.name, bart.get_grade())
```


## 访问限制 

如果要让类的变量不被外部访问可以使用``__``开头的变量名

```PY 
class Student(object):
    def __init__(self,name,score):
        self.__name=name
        self._score=score
    def print_score(self)
        print('%s %s' % (self.__name,self.__score))
```


## 继承 

```py 
#!/usr/bin/env python3
# -*- coding: utf-8 -*-

class Animal(object):
    def run(self):
        print('Animal is running...')

class Dog(Animal):
    def run(self):
        print('Dog is running...')

class Cat(Animal):
    def run(self):
        print('Cat is running...')

def run_twice(animal):
    animal.run()
    animal.run()

a = Animal()
d = Dog()
c = Cat()

print('a is Animal?', isinstance(a, Animal))
print('a is Dog?', isinstance(a, Dog))
print('a is Cat?', isinstance(a, Cat))

print('d is Animal?', isinstance(d, Animal))
print('d is Dog?', isinstance(d, Dog))
print('d is Cat?', isinstance(d, Cat))

run_twice(c)
```