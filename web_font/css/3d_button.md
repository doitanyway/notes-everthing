# 一个3d button


## 简介

本文演示如何编写一个3D按钮，如果需要看效果，可以查看：https://codepen.io/qiujiahong/pen/YYEjex


# http

```html
<h1> This button does nothing</h1>
<button class="btn">click me</button>
```

## css

```css
body{
  background-color: #fcd04b;
  font-family: Lato;
  color: white;
}
h1{
  text-align: center;
  font-weight: 300px;
}
.btn{
  outline: none;
  border: none;
  cursor: pointer;
  display: block;
  position: relative;
  background-color: #fcad26;
  font-size: 16px;
  font-weight: 300px;
  color: white;
  text-transform: uppercase;
  letter-spacing: 2px;
  padding: 25px 80px;
  margin: 0 auto;
  border-radius: 20px;
  box-shadow: 0px 6px #efa424
}

.btn:hover{
  box-shadow: 0px 4px #efa424;
  top: 2px;
}

.btn:active{
/*   box-shadow: 0px 0px #efa424; */
  box-shadow: none;  
  top: 4px;
}
```

