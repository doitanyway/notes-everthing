# 元素的运维

## get & set


* ``.html()`` – Get or set the HTML contents.
* ``.text()`` – Get or set the text contents; HTML will be stripped.
* ``.attr()`` – Get or set the value of the provided attribute.
* ``.width()`` – Get or set the width in pixels of the first element in the selection as an integer.
* ``.height()`` – Get or set the height in pixels of the first element in the selection as an integer.
* ``.position()`` – Get an object with position information for the first element in the selection, relative to its first positioned ancestor. This is a getter only.
* ``.val()`` – Get or set the value of form elements.

eg:
```js
$( "#myDiv p:first" ).html( "New <strong>first</strong> paragraph!" );
```

## 移动、拷贝、删除


* Place the selected element(s) relative to another element. 
* Place an element relative to the selected element(s).

* ``.insertAfter()`` 待放置元素作为参数，放置参数元素在选择元素后面；
* ``.after().`` 待放置元素是选择元素，放置选中的元素到参数元素后面；
* ``.insertBefore()`` and ``.before()``, ``.appendTo()`` and ``.append()``, and ``.prependTo()`` and ``.prepend()``，这几个函数也是这个套路；

```js
// Moving elements using different approaches.
 
// Make the first list item the last list item:
var li = $( "#myList li:first" ).appendTo( "#myList" );
 
// Another approach to the same problem:
$( "#myList" ).append( $( "#myList li:first" ) );
 
// Note that there's no way to access the list item
// that we moved, as this returns the list itself.
```

## 克隆元素 ``.clone`` 

```js
// Making a copy of an element.
 
// Copy the first list item to the end of the list:
$( "#myList li:first" ).clone().appendTo( "#myList" );
```

## 删除

* ``.remove()``,用于长期的删除元素，这个方法返回值将是这个元素，将恢复元素的时候，之前的data和event都将不复存在；

* ``.detach() ``,用于临时删除元素；

## 创建

jquary可以用符号``$()``方法，创建选择器：  
```js
// Creating new elements from an HTML string.
$( "<p>This is a new paragraph</p>" );
$( "<li class=\"new\">new list item</li>" );
```

```js
// Creating a new element with an attribute object.
$( "<a/>", {
    html: "This is a <strong>new</strong> link",
    "class": "new",
    href: "foo.html"
});
```
注意：上面第二种方法，属性``class``有用引号，其他两个没有，属性名称一般来说都不用加引号，除非他们是[保留关键字](https://mathiasbynens.be/notes/reserved-keywords),如``class``。

创建了元素之后，不会立即显示在页面上，有几种方法可以显示在页面上,下面是一个例子：

```js
// Getting a new element on to the page.
 
var myNewElement = $( "<p>New element</p>" );
 
myNewElement.appendTo( "#content" );
 
myNewElement.insertAfter( "ul:last" ); // This will remove the p from #content!
 
$( "ul" ).last().after( myNewElement.clone() ); // Clone the p so now we have two.
```

我们也可以直接插入新的元素。

```js
// Creating and adding an element to the page at the same time.
$( "ul" ).append( "<li>list item</li>" );
```

如果是加入很多元素可以使用数组和循环：

```js
var myItems = [];
var myList = $( "#myList" );
 
for ( var i = 0; i < 100; i++ ) {
    myItems.push( "<li>item " + i + "</li>" );
}
 
myList.append( myItems.join( "" ) );
```

## 维护属性

```js
// Manipulating a single attribute.
$( "#myDiv a:first" ).attr( "href", "newDestination.html" );
```

```js
// Manipulating multiple attributes.
$( "#myDiv a:first" ).attr({
    href: "newDestination.html",
    rel: "nofollow"
});
```

```js
// Using a function to determine an attribute's new value.
$( "#myDiv a:first" ).attr({
    rel: "nofollow",
    href: function( idx, href ) {
        return "/new/" + href;
    }
});
 
$( "#myDiv a:first" ).attr( "href", function( idx, href ) {
    return "/new/" + href;
});
```