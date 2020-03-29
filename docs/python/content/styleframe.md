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
                          styler_obj=Styler(bg_color=utils.colors.blue, bold=True, font_size=10))

# 定义样式到指定列
# sf.apply_column_style(cols_to_style=['col_b'], styler_obj=Styler(bg_color=utils.colors.green),
#                       style_header=True)


# 写文件
ew = StyleFrame.ExcelWriter(r'./my_excel.xlsx')
sf.to_excel(ew)
ew.save()

```

### 连续应用多个样式   

* 链式调用（构造者模式）

```py   
# coding:utf-8

from StyleFrame import StyleFrame, Styler, utils

# 创建一个StyleFrame对象
sf = StyleFrame(
    {'col_a': range(100),
     'col_b': range(100)})

# 连续应用多个样式
sf.apply_style_by_indexes(indexes_to_style=sf[sf['col_a'] > 50],
                          cols_to_style=['col_a'],
                          styler_obj=Styler(bg_color=utils.colors.blue, bold=True, font_size=10)).\
    apply_column_style(cols_to_style=['col_b'],
                       styler_obj=Styler(bg_color=utils.colors.green),
                       style_header=True)
# 写文件
ew = StyleFrame.ExcelWriter(r'./my_excel.xlsx')
# sf.to_excel(ew)
sf.to_excel(excel_writer=ew, sheet_name="第一个")
ew.save()
```

* 分开调用  

```py 

# coding:utf-8

from StyleFrame import StyleFrame, Styler, utils

# 创建一个StyleFrame对象
sf = StyleFrame(
    {'col_a': range(100),
     'col_b': range(100)})

# 连续应用多个样式
sf = sf.apply_style_by_indexes(indexes_to_style=sf[sf['col_a'] > 50],
                          cols_to_style=['col_a'],
                          styler_obj=Styler(bg_color=utils.colors.blue, bold=True, font_size=10))

sf.apply_column_style(cols_to_style=['col_b'],
                       styler_obj=Styler(bg_color=utils.colors.green),
                      width=100,
                       style_header=True)
# 写文件
ew = StyleFrame.ExcelWriter(r'./my_excel.xlsx')
# sf.to_excel(ew)
sf.to_excel(excel_writer=ew, sheet_name="第一个")
ew.save()


```

### API  

* ``StyleFrame.to_excel``，保存EXCEL信息，[更多介绍](https://styleframe.readthedocs.io/en/latest/api_documentation.html#StyleFrame.StyleFrame.to_excel)

```py 
StyleFrame.to_excel(excel_writer='output.xlsx', sheet_name='Sheet1', allow_protection=False, right_to_left=False, columns_to_hide=None, row_to_add_filters=None, columns_and_rows_to_freeze=None, best_fit=None)
```


* ``StyleFrame.apply_style_by_indexes``,应用样式到一些选中的单元格中,[更多介绍](https://styleframe.readthedocs.io/en/latest/api_documentation.html#StyleFrame.StyleFrame.apply_style_by_indexes)

```py 
StyleFrame.apply_style_by_indexes(indexes_to_style, styler_obj, cols_to_style=None, height=None, complement_style=None, complement_height=None, overwrite_default_style=True)
```

* ``StyleFrame.apply_column_style``,应用样式到一个指定列中，[更多介绍](https://styleframe.readthedocs.io/en/latest/api_documentation.html#StyleFrame.StyleFrame.apply_column_style)   

```py 
StyleFrame.apply_column_style(cols_to_style, styler_obj, style_header=False, use_default_formats=True, width=None, overwrite_default_style=True)
```

* ``Styler``对象定义了表格样式，[更多介绍](https://styleframe.readthedocs.io/en/latest/api_documentation.html#Styler)

```py 
Parameters:	
bg_color (str: one of utils.colors, hex string or color name ie ‘yellow’ Excel supports) – The background color
bold (bool) – If True, a bold typeface is used
font (str: one of utils.fonts or other font name Excel supports) – The font to use
font_size (int) – The font size
font_color (str: one of utils.colors, hex string or color name ie ‘yellow’ Excel supports) – The font color
number_format (str: one of utils.number_formats or any other format Excel supports) – The format of the cell’s value
protection (bool) – If True, the cell/column will be write-protected
underline (str: one of utils.underline or any other underline Excel supports) – The underline type
border_type (str: one of utils.borders or any other border type Excel supports) – The border type
horizontal_alignment (str: one of utils.horizontal_alignments or any other horizontal alignment Excel supports) – Text’s horizontal alignment
vertical_alignment (str: one of utils.vertical_alignments or any other vertical alignment Excel supports) – Text’s vertical alignment
wrap_text (bool) –
shrink_to_fit (bool) –
fill_pattern_type (str: one of utils.fill_pattern_types or any other fill pattern type Excel supports) – Cells’s fill pattern type
indent (int) –
comment_author (str) –
comment_text (str) –
text_rotation (int) – Integer in the range 0 - 180
```