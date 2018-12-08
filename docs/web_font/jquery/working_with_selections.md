# 选择器使用


## getter && setter 

一些jquery方法，可以用来给selection赋值或者读值，当这个方法被带参数的方法调用时，该方法为一个setter；当该方法不带参数则是当作一个getter使用。

* setter,该方法返回一个对象，所以我们可以利用这个对象继续调用``$( "h1" ).html().addClass( "test" );``  

```js
// The .html() method sets all the h1 elements' html to be "hello world":
$( "h1" ).html( "hello world" );
```

* getter,该方法返回我们获取的值。

```js
// The .html() method returns the html of the first h1 element:
$( "h1" ).html();
// > "hello world"
```

## chaining

如果我们在一个选择器上调用一个方法，那个方法返回一个JQ对象，你可以继续调用JQ方法在这个对象上，这样的用法我们叫做``chaining``。


```js
$( "#content" )
    .find( "h3" )
    .eq( 2 )
    .html( "new text for the third h3!" );
```

jquery也提供了一个``.end``方法去返回原来的选择器


```js
$( "#content" )
    .find( "h3" )
    .eq( 2 )
        .html( "new text for the third h3!" )
        .end() // Restores the selection to all h3s in #content
    .eq( 0 )
        .html( "new text for the first h3!" );
```
