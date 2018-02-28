# 便利访问jquery以及非jquery对象

## .each: 

```js
var sum = 0;
var arr = [ 1, 2, 3, 4, 5 ];
for ( var i = 0, l = arr.length; i < l; i++ ) {
    sum += arr[ i ];
}
console.log( sum ); // 15
```

```js
$.each( arr, function( index, value ){
    sum += value;
});
 
console.log( sum ); // 15
```

```js
var sum = 0;
var obj = {
    foo: 1,
    bar: 2
}
for (var item in obj) {
    sum += obj[ item ];
}
 
console.log( sum ); // 3
```

```js
$.each( obj, function( key, value ) {
    sum += value;
});
 
console.log( sum ); // 3
```

这里需要注意的是，该用法是针对简单对象，不是jquery对象。 以下用法是错误的：  
```js
// Incorrect:
$.each( $( "p" ), function() {
    // Do something
});
```


## .each()在jquery的用法

```html
<ul>
    <li><a href="#">Link 1</a></li>
    <li><a href="#">Link 2</a></li>
    <li><a href="#">Link 3</a></li>
</ul>
```

```js
$( "li" ).each( function( index, element ){
    console.log( $( this ).text() );
});
 
// Logs the following:
// Link 1
// Link 2
// Link 3
```

## .each是否有必要

* 一些.each是没必要的

```js
$( "li" ).each( function( index, el ) {
    $( el ).addClass( "newClass" );
});
```
如上，我们可以批量一次完成：  
```js
$( "li" ).addClass( "newClass" );
```

* 一些.each又是必须

以下代码不能正常工作：

```js
// Doesn't work:
$( "input" ).val( $( this ).val() + "%" );
 
// .val() does not change the execution context, so this === window
```

应该这样：

```js
$( "input" ).each( function( i, el ) {
    var elem = $( el );
    elem.val( elem.val() + "%" );
});
```

* 需要循环的方法
    * .attr() (getter)
    * .css() (getter)
    * .data() (getter)
    * .height() (getter)
    * .html() (getter)
    * .innerHeight()
    * .innerWidth()
    * .offset() (getter)
    * .outerHeight()
    * .outerWidth()
    * .position()
    * .prop() (getter)
    * .scrollLeft() (getter)
    * .scrollTop() (getter)
    * .val() (getter)
    * .width() (getter)

## .map()

用来创建一个数组：

```js
var newArr = [];
 
$( "li" ).each( function() {
    newArr.push( this.id );
});
```

```js
var newArr = $( "li" ).map( function(index, element) {
    return this.id;
}).get().join();
```

## $.map

```html
<li id="a"></li>
<li id="b"></li>
<li id="c"></li>

<script>
var arr = [{
    id: "a",
    tagName: "li"
}, {
    id: "b",
    tagName: "li"
}, {
    id: "c",
    tagName: "li"
}];
 
// Returns [ "a", "b", "c" ]
$( "li" ).map( function( index, element ) {
    return element.id;
}).get();
 
// Also returns [ "a", "b", "c" ]
// Note that the value comes first with $.map
$.map( arr, function( value, index ) {
    return value.id;
});
 
</script>
```