# jquery对象

当我们创建一个新的元素的时候（或者选择一个已经存在的元素），jquery返回一个collection，很多新的jQuery开发者都认为这一个集合是array,它有一个z顺序的Dom元素，一些熟悉array函数，以及一个``.length``属性，其实jQuery对象有更多内容。


## Dom 以及DOM元素

Doucument object model(DOM),代表html文档，可以有多个dom元素，很高层次上，dom元素可以看成一小片的web页面，它可能包含字符，以及其他DOM元素，DOM元素如何显示由类型以及属性决定。

## jQuary对象

使用DOM直接操作，有时候比较复杂jQuary简化了这个操作,如：

```js
// Setting the inner HTML with jQuery.
 
var target = document.getElementById( "target" );
 
$( target ).html( "<td>Hello <b>World</b>!</td>" );
```

```js
// Inserting a new element after another with jQuery.
 
var target = document.getElementById( "target" );
 
var newElement = document.createElement( "div" );
 
$( target ).after( newElement );
```


## 获取元素到jquery object

jquery引用了css的选择器，将会返回一个jQuery object包，这个包将会包含所有匹配这个selecter的元素  
```js
// Selecting all <h1> tags.
var headings = $( "h1" );
```
我们可以通过检查长度看是否有元素被选中：  
```js
// Viewing the number of <h1> tags on the page.
var headings = $( "h1" );
alert( headings.length );
```

如果我们的目标只是选取第一个元素，则可以这样：   
```js
// Selecting only the first <h1> element on the page (in a jQuery object)
var headings = $( "h1" );
var firstHeading = headings.eq( 0 );
```

```js
// Selecting only the first <h1> element on the page.
var firstHeadingElem = $( "h1" ).get( 0 );
```

```js 
// Selecting only the first <h1> element on the page (alternate approach).
var firstHeadingElem = $( "h1" )[ 0 ];
```