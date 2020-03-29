# python读写EXCEL（pandas）


本文介绍如何使用python读写excel。使用的模组为pandas，操作前需要安装如下依赖： 

```bash 
pip install pandas openpyxl
# pip3 install pandas
```

## 简单读写

* 读  
```python
import pandas as pd

df = pd.read_excel('工作簿1.xlsx', sheet_name='Sheet1')
print(df.head())


```

* 写   

```python 

# coding:utf-8

import pandas as pd
from pandas import DataFrame

data = {
    '序号': [1, 2],
    '姓名': ["张三", "李四"],
    'age': [12, 22],
    '出生日期': ["2020-02-12 12:00:00", "2020-02-22"],
    }

df = DataFrame(data)

df.to_excel("work.xlsx")
```

## read_excel方法 

* 函数格式   

```py 
pd.read_excel(io, sheet_name=0, header=0, names=None, index_col=None, usecols=None)

```


> io：excel文件，如果命名为中文，在python2.7中，需要使用decode()来解码成unicode字符串，例如： pd.read_excel('示例'.decode('utf-8))
> sheet_name：返回指定的sheet，如果将sheet_name指定为None，则返回全表，如果需要返回多个表，可以将sheet_name指定为一个列表，例如['sheet1', 'sheet2']
> header：指定数据表的表头，默认值为0，即将第一行作为表头。
> usecols：读取指定的列，例如想要读取第一列和第二列数据：
>    pd.read_excel("example.xlsx", sheet_name=None, usecols=[0, 1])