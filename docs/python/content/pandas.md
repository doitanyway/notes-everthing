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