# i标签放图片

* html 

```html 
<div class="hover right">
    <i class="log_change state_psd"></i>
</div>
```


```css
.log_change{
  display: inline-block;
  width: 50px;
  height: 40px;
  margin-top: 10px;
}
.state_psd{
  background:url(../images/密码修改.png) no-repeat center;
}
```


注意：  i标签需显示为块级元素，加上宽高属性占位

display: inline-block;
width: 50px;
height: 40px;

 类似img标签，宽高属性按照规范是需要赋值，先占位
