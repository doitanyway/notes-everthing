# jQuery’s .index()

## .index没有参数

```html
<ul>
    <div></div>
    <li id="foo1">foo</li>
    <li id="bar1">bar</li>
    <li id="baz1">baz</li>
    <div></div>
</ul>
```

```js
var foo = $( "#foo1" );
 
console.log( "Index: " + foo.index() ); // 1
 
var listItem = $( "li" );
 
// This implicitly calls .first()
console.log( "Index: " + listItem.index() ); // 1
console.log( "Index: " + listItem.first().index() ); // 1
 
var div = $( "div" );
 
// This implicitly calls .first()
console.log( "Index: " + div.index() ); // 0
console.log( "Index: " + div.first().index() ); // 0
```

由上可以看出，.index返回其在父亲下的位置值（从0开始）。


## index() 带一个string参数

```html
<ul>
    <div class="test"></div>
    <li id="foo1">foo</li>
    <li id="bar1" class="test">bar</li>
    <li id="baz1">baz</li>
    <div class="test"></div>
</ul>
<div id="last"></div>
```

```js
var foo = $( "li" );
 
// This implicitly calls .first()
console.log( "Index: " + foo.index( "li" ) ); // 0
console.log( "Index: " + foo.first().index( "li" ) ); // 0 满足选择器的li元素在父亲下的所有li的位置序号
 
var baz = $( "#baz1" );
console.log( "Index: " + baz.index( "li" )); // 2   ,满足选择器的li元素在父亲下的所有li的位置序号
 
var listItem = $( "#bar1" );
console.log( "Index: " + listItem.index( ".test" ) ); // 1
 
var div = $( "#last" );
console.log( "Index: " + div.index( "div" ) ); // 2
```

## index 用一个jquery对象作为参数

```js
<ul>
    <div class="test"></div>
    <li id="foo1">foo</li>
    <li id="bar1" class="test">bar</li>
    <li id="baz1">baz</li>
    <div class="test"></div>
</ul>
<div id="last"></div>
```

```js
var foo = $( "li" );
var baz = $( "#baz1" );
 
console.log( "Index: " + foo.index( baz ) ); // 2
 
var tests = $( ".test" );
var bar = $( "#bar1" );
 
// Implicitly calls .first() on the argument.
console.log( "Index: " + tests.index( bar ) ); // 1
 
console.log( "Index: " + tests.index( bar.first() ) ); // 1
```
