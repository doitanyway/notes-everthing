# 循环-for & while

```py
# for 循环
students=['nick','elaine','lucy']
for s in students:
  print(s)

# while循环
sum = 0
n = 99
while n > 0:
    sum = sum + n
    n = n - 2
print(sum)

# break,调用break的时候跳出整个循环
sum = 0
n = 99
while n > 0:
  if n > 20: 
    break
  sum = sum + n
  n = n - 2
print(sum)


# continue,调用continue的时候跳出本次循环
sum = 0
n = 99
while n > 0:
  if n > 20: 
    continue
  sum = sum + n
  n = n - 2
print(sum)
```


