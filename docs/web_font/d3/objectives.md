# D3 objectives

## objectives

* d3 selection链接数据方法；
* 通过enter selection添加target notes到DOM;
* 通过exit selction从dom删除target notes
* 更高级的数据绑定函数
* 更新已经存在的dom元素以及数据
* 合并update 和 enter selections，d3升级模式；


## enter selctions 方法


```html
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Data Joins with D3</title>
</head>
<body>
<h1>Movie quotes.</h1>
<ul id="quotes">
</ul>
<script src="https://d3js.org/d3.v4.js"></script>
<script src="app.js"></script>
</body>
</html>
```

```js
var quotes = [
    {
        quote: "I see dead people.",
        movie: "The Sixth Sense",
        year: 1999,
        rating: "PG-13"
    }, {
        quote: "May the force be with you.",
        movie: "Star Wars: Episode IV - A New Hope",
        year: 1977,
        rating: "PG"
    }, {
        quote: "You've got to ask yourself one question: 'Do I feel lucky?' Well, do ya, punk?",
        movie: "Dirty Harry",
        year: 1971,
        rating: "R"
    }, {
        quote: "You had me at 'hello.'",
        movie: "Jerry Maguire",
        year: 1996,
        rating: "R"
    }, {
        quote: "Just keep swimming. Just keep swimming. Swimming, swimming, swiming.",
        movie: "Finding Nemo",
        year: 2003,
        rating: "G"
    }
];

d3.select("#quotes")                    //选择ul元素
    .style("list-style","none")        //设置风格
    .selectAll("li")                       //选择li,一个空的D3
    .data(quotes)                       //这里面有enter 以及 exit两个属性
    .enter()
    .append("li")
        .text(function (d) {
            return '"'+d.quote+'" - ' + d.movie+ '(' + d.year + ')';
        })
    .style("margin","20px")
    .style("padding","20px")
    .style("font-size",function (d) {
        return d.quote.length < 25 ? "2em":"1em";
    });
```


简写
```js
d3.select("#quotes")                    //选择ul元素
    .style("list-style","none")        //设置风格
    .selectAll("li")                       //选择li,一个空的D3
    .data(quotes)                       //这里面有enter 以及 exit两个属性
    .enter()
    .append("li")
        .text(d => '"'+d.quote+'" - ' + d.movie+ '(' + d.year + ')')
    .style("margin","20px")
    .style("padding","20px")
    .style("font-size", d => d.quote.length < 25 ? "2em":"1em");

```


* 根据不同等级显示不同颜色；

```js
var colors ={
    "G":"#3cff00",
    "PG": "#f9ff00",
    "PG-13": "#ff9000",
    "R": "#ff0000"
}

d3.select("#quotes")                    //选择ul元素
    .style("list-style","none")        //设置风格
    .selectAll("li")                       //选择li,一个空的D3
    .data(quotes)                       //这里面有enter 以及 exit两个属性
    .enter()
    .append("li")
        .text(d => '"'+d.quote+'" - ' + d.movie+ '(' + d.year + ')')
    .style("margin","20px")
    .style("padding","20px")
    .style("font-size", d => d.quote.length < 25 ? "2em":"1em")
    .style("background-color", d => colors[d.rating])
    .style("border-radius","8px");

```


## exit selctions 方法

* 删除最后一个数据
    * quotes.pop()
    * d3.selectAll("li").data(quotes).exit().remove()

* 删除R级别的数据

```js
var nonRQutotes = quotes.filter(function(movie){
	return movie.rating !== "R";
});

d3.selectAll("li")
	.data(nonRQutotes,function(d){
		return d.quote;
	}).exit()
	.remove();
```
