# transitions(过渡)

## 作用

控制动画的速度,如按3S时间增大div.

官方介绍： https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Transitions/Using_CSS_transitions

工具： http://easings.net
工具2： http://cubic-bezier.com/

## transition属性

* transition-duration 
* transition-property
* transition-timing-function
* transition-delay

## 例子

```css
<p class="box">boring</p>
<p class="animated box">Animated</p>
```

```css
.box{
  background: #9b59b6;
  height: 100px;
  width: 100px;
  line-height: 100px;
  text-align: center;
  color: white;
  font-size: 17px;
  border-radius: 20px;
}

.box:hover{
  background: #e74c23;
  transform-origin: top left;
  transform:scale(2) ;
  border-radius: 50px;
/*   opacity: 0.5; */
}
.animated{
  transition-duration: 0.3s;
/*   transition-property: background-color; */
/*    transition-property: transform; */
   transition-property: background,border-radius;
}
```

example: https://codepen.io/qiujiahong/pen/MrOzGN?editors=1100#0



## transition-timing-function

```css
<p class="box">boring</p>
<p class="animated box">Animated</p>
```

```css
.box{
  background: #9b59b6;
  height: 100px;
  width: 100px;
  line-height: 100px;
  text-align: center;
  color: white;
  font-size: 17px;
  border-radius: 20px;
}

.box:hover{
  transform: translateX(300px);
}
.animated{
  transition-property: transform;
  transition-duration: 2s;
/*   transition-timing-function: linear; */
/*   transition-timing-function: ease-out; */
/*   transition-timing-function: ease-in; */
  transition-timing-function: cubic-bezier(.02,.7,0,1.08);
}
```

example:https://codepen.io/qiujiahong/pen/BJmMBo?editors=1100#0




## transition 快捷方式

```css
<p class="box">boring</p>
<p class="animated box">Animated</p>
```

```css
.box{
  background: #9b59b6;
  height: 100px;
  width: 100px;
  line-height: 100px;
  text-align: center;
  color: white;
  font-size: 17px;
  border-radius: 20px;
}

.box:hover{
  transform: translateX(300px);
  background-color: teal;
}
.animated{
  transition:  transform 2s ease-out 1s,background-color 2s linear;
/* transition-property: transform;
  transition-duration: 2s; 
  transition-timing-function: cubic-bezier(.02,.7,0,1.08);
  transition-delay: 1s; */
}

```


https://developer.mozilla.org/en-US/docs/Web/CSS/transition


## 动画的效率

https://www.html5rocks.com/en/tutorials/speed/high-performance-animations/

