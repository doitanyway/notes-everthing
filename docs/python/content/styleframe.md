# StyleFrame样式


## 前言

StyleFrame对EXCEL样式控制非常好，使用StyleFrame需要安装依赖：  

```bash 
pip install styleframe
```

## 例子 

### 基础使用   

```py 
# coding:utf-8

from StyleFrame import StyleFrame, Styler, utils

# 创建一个StyleFrame对象
sf = StyleFrame(
    {'col_a': range(100),
     'col_b': range(100)})

# 定义样式到指定列里面指定条件的格
sf.apply_style_by_indexes(indexes_to_style=sf[sf['col_a'] > 50],
                          cols_to_style=['col_a'],
                          styler_obsj=Styler(bg_color=utils.colors.blue, bold=True, font_size=10))

# 定义样式到指定列
# sf.apply_column_style(cols_to_style=['col_b'], styler_obj=Styler(bg_color=utils.colors.green),
#                       style_header=True)


# 写文件
ew = StyleFrame.ExcelWriter(r'./my_excel.xlsx')
sf.to_excel(ew)
ew.save()

```