# 数据过滤函数-filter


```PY 
# 数据过滤函数-filter,只保留奇数
def is_odd(n):
    return n % 2 == 1

var = list(filter(is_odd, [1, 2, 3, 4, 5, 6, 7]))

print(var)


```