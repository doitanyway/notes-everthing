# 对齐-ljust/rjust

```py 

str_test = "hello word"
# 左对齐，不足20个字符，则用20个字符补齐
# hello word
print(str_test.ljust(20));

# 右对齐
print(str_test.rjust(20))

# 指定填充
print(str_test.rjust(20,'*'))
```