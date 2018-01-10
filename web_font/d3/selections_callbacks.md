# selections && callbacks

## 方法
* selection.style(propery[,callback])
* selection.attr(attribute[.callback])
* selection.text([callback])
* selection.html([callback])


## 例子

* 例子对象html

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>D3 and the DOM</title>
</head>
<body>
  <h1 id="page-title">This is my first D3 example!</h1>
  <p class="first-paragraph">Here's my first paragraph.</p>
  <p>Here are some reasons why d3 is cool:</p>
  <ol>
    <li>Makes data more engaging.</li>
    <li>Has built-in math helpers.</li>
    <li>Supports graph animations.</li>
    <li>Makes drawing graph axes a breeze!</li>
  </ol>
  <div class="outer">
    Here's an outer div.
    <div>
      Here's an inner div.
      <div>
        Here's the last div.
      </div>
    </div>
  </div>
  <script src="https://d3js.org/d3.v4.js"></script>
</body>
</html>
```

* 给选中元素分配随机大小的字体

```js
d3.selectAll("li")
	.style("font-size",function(){
		return Math.random()*40+"px";	
	 });
```

* 根据奇偶数写背景

```js
d3.selectAll("li")
	.style("background-color",function(_,idx){
		return idx%2 === 0 ? "lightgrey" : "white";
	});
```

* 从外向内选择

```js
d3.selectAll(".outer")              //选择外层div，把所有文字颜色变成purple
	.style("color","purple")
	.select("div")                  //选择里面一层div把所有字号变成30px
	.style("font-size","30px")
	.select("div")                  //选择再里面一层div更改边框
	.style("border","8px solid blue");
```



