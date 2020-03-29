
# python读写EXCEL（xlrd、xlwt）

## 简介

本文介绍如何使用python读写excel。使用的模组为xlrd和xlwt，操作前需要安装如下依赖： 

```bash 
pip install xlrd xlwt
```

> 本文为一个简单的例例子，用来辅助对比不同模组读写，EXCEL，实际读写建议使用pandas，更加简单。


## 读EXCEL

```python
import xlrd
from datetime import datetime
from xlrd import xldate_as_datetime, xldate_as_tuple

book = xlrd.open_workbook('工作簿1.xlsx')

sheet1 = book.sheets()[0]

# 获取总行列数
nrows = sheet1.nrows
print('表格总行数',nrows)
ncols = sheet1.ncols
print('表格总列数',ncols)

# 获取一行值
row3_values = sheet1.row_values(2)
print('第3行值', row3_values)

# 获取一个单元格值，并强制转换结果
cell_3_4 = sheet1.cell(2, 3).value
print('第3行第4列的单元格的值：', cell_3_4, int(cell_3_4), type(cell_3_4))  

# 处理日期
# ctype： 0 empty,1 string, 2 number, 3 date, 4 boolean, 5 error
ctype = sheet1.cell(2, 4).ctype
print("type:" + str(ctype))
sCell = sheet1.cell_value(2, 4)
#ctype =3,为日期
if ctype == 3:
    date = datetime(*xldate_as_tuple(sCell, 0))
    print("data:", date, type(date))
    cell = date.strftime('%Y-%m-%d')
    # cell = date.strftime('%Y/%m/%d %H:%M:%S')
    print(cell)
else:
    pass

```

## 写EXCEL(xlwt)

据说不支持excel2007的xlsx格式

```python
import xlwt 

workbook = xlwt.Workbook()

worksheet = workbook.add_sheet('test')

worksheet.write(0,0,'A1data')

workbook.save('excelwrite.xls')

```