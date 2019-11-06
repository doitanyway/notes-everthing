# 模块

## 模块使用

```py 
#!/usr/bin/env python3
# -*- coding: utf-8 -*-

' a test module '

__author__ = 'Michael Liao'
# 导入模块
import sys

def test():
    # 使用模块
    args = sys.argv
    if len(args)==1:
        print('Hello, world!')
    elif len(args)==2:
        print('Hello, %s!' % args[1])
    else:
        print('Too many arguments!')

if __name__=='__main__':
    test()
```



## 第三方模块

### 安装

第三方模块通过pip命令安装,官方的pip第三方库为https://pypi.python.org/

```BASH 
pip install Pillow
# 在python3和python2都存在的环境使用如下命令
pip3 install Pillow
```

### 使用 

```PY 
# 使用import可以导入模块，如果模块找不到会报错
import mymodule
# python解释器会尝试在当前目录、已安装得内置模块和第三方模块，以及sys模块的path变量中的路径
```


###  添加自己的搜索目录

```py 
# 修改sys.path
 import sys
 sys.path.append('/Users/michael/my_py_scripts')
#  设置环境变量 PYTHONPATH
```