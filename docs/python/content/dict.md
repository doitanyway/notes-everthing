# dict 

dict用法与java语言中的map类似，使用key-value方式存储


```py 
# 声明一个dist
d = {'Nick': 30, 'Elaine': 20}

print(d['Nick'])
# 重新赋值
d['Nick']=35
print('Nick is',d['Nick'])

# 不存在报错  KeyError: 'nick',且代码停止运行
# print(d['nick'])

# 判断是否存在
print('nick' in d)
print('Nick' in d)

# 删除一个key
d.pop('Nick')

```