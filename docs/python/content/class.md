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