# list类型

list 是一种集合类型，可以添加和删除元素。



```py
# list声明
teachers = ['Lucy','Lili','Mark']

print(len(teachers))
print("访问元素:")
print(teachers)
print("遍历元素:")
for t in teachers: 
  print(t)

print("访问其中一个元素:")
print(teachers[0])

print("访问最后一个元素:")
print(teachers[-1])

print("添加 Adam:")
teachers.append('Adam')
print(teachers)

print("添加 LiLei到位置1:")
teachers.insert(1, 'LiLei')
print(teachers)

print("删除末尾数据:")
teachers.pop()
print(teachers)

print("删除位置1数据(0开始):")
teachers.pop(1)
print(teachers)

# 数组嵌套
s = ['python', 'java', ['asp', 'php'], 'scheme']
len(s)
# 4

```