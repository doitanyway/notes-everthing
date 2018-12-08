# transform（改变）

## 官方说明

* transform : https://developer.mozilla.org/en-US/docs/Web/CSS/transform?v=control

* transform-origin: https://developer.mozilla.org/en-US/docs/Web/CSS/transform-origin




## translateX & translateY 

* 功能：改变坐标位置:  
* example:


```html
<p></p>
<p class="move-right"></p>
<p></p>
<p class="move-down"></p>
```

```css
p{
  width: 50px;
  height: 50px;
  background-color: #1abc9c;
}
p.move-right{
  background-color: #3498ab;
  transform: translateX(100px);
}

p.move-down{
  background-color: #f1c40f;
  transform: translateY(20px);  
}
p:hover{
  transform: translate(20px,20px);
}
```

* 效果演示 : https://codepen.io/qiujiahong/pen/baYjjQ

## scale

* 功能： 增加或者减少尺寸；

* example: 

```html
<p>hello</p>
<p class="transformed">hello</p>
```

```css
p{
  width: 50px;
  height: 50px;
  background-color: #1abc9c;
  color: #ecf0f1;
  border: 2px solid #2c3e50;
}
.transformed{
  background-color: #3498db;
  transform: scale(2);
/*   transform: scale(1,2); */
/*   transform-origin: 0 0; */
/*   transform-origin: left; */
  transform-origin: left top; 
/*   transform-origin: left bottom;  */
}
```

* 效果演示：https://codepen.io/qiujiahong/pen/dJZjQz



## rotations

* 功能：rotate 翻转

* example：

```html
<p>hello</p>
<p class="transformed">hello</p>
```

```css
p{
  background-color: red;
  width: 50px;
  height: 50px;
  border: 2px solid #2c3e50;
}
.transformed{
  background-color: #9b59b6;
  transform: rotate(45deg);
  transform-origin: right bottom;
}
```


* 演示： https://codepen.io/qiujiahong/pen/WdXKmW

## rotate && translateX 同时使用

```css
p{
  background-color: red;
  width: 50px;
  height: 50px;
  border: 2px solid #2c3e50;
}
.transformed{
  background-color: #9b59b6;
  transform: rotate(45deg) translateX(100px);
  transform-origin: right bottom;
}
```