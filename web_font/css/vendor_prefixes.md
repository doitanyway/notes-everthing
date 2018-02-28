# 浏览器的兼容文体

为解决浏览器兼容性文体，一些css属性需要解决兼容性问题，可以给一些属性加前缀，如：

* 处理前
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

* 处理后
```css
p{
  background-color: red;
  width: 50px;
  height: 50px;
  border: 2px solid #2c3e50;
}
.transformed{
  background-color: #9b59b6;
  -webkit-transform: rotate(45deg) translateX(100px);
      -ms-transform: rotate(45deg) translateX(100px);
          transform: rotate(45deg) translateX(100px);
  -webkit-transform-origin: right bottom;
      -ms-transform-origin: right bottom;
          transform-origin: right bottom;
}
```

官方介绍：https://developer.mozilla.org/en-US/docs/Glossary/Vendor_Prefix#CSS_prefixes

帮助工具：
* 在线： https://autoprefixer.github.io/
* 离线： http://pleeease.io/