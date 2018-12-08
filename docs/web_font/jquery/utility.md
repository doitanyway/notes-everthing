# 工具方法

jQuery在$名称空间下，提供了很多工具方法，那些方法在编程时非常又有用。  
下面就列举一些常用的方法:

* $.trim()，删除头尾的空格：
```js
// Returns "lots of extra whitespace"
$.trim( "    lots of extra whitespace    " );
```

* $.each(),遍历列表或者对象:

```js
$.each([ "foo", "bar", "baz" ], function( idx, val ) {
    console.log( "element " + idx + " is " + val );
});
 
$.each({ foo: "bar", baz: "bim" }, function( k, v ) {
    console.log( k + " : " + v );
});
```

* $.inArray(),返回值的位置，如果不能找到该值，则返回-1

```js
var myArray = [ 1, 2, 3, 5 ];
 
if ( $.inArray( 4, myArray ) !== -1 ) {
    console.log( "found it!" );
}
```

* $.extend() 修改第一个对象的属性，改成第二个对象的值

```js
var firstObject = { foo: "bar", a: "b" };
var secondObject = { foo: "baz" };
 
var newObject = $.extend( firstObject, secondObject );
 
console.log( firstObject.foo ); // "baz"
console.log( newObject.foo ); // "baz"
```

If you don't want to change any of the objects you pass to $.extend(), pass an empty object as the first argument:
```js
var firstObject = { foo: "bar", a: "b" };
var secondObject = { foo: "baz" };
 
var newObject = $.extend( {}, firstObject, secondObject );
 
console.log( firstObject.foo ); // "bar"
console.log( newObject.foo ); // "baz"
```

* $.proxy() Returns a function that will always run in the provided scope — that is, sets the meaning of this inside the passed function to the second argument.

```js
var myFunction = function() {
    console.log( this );
};
var myObject = {
    foo: "bar"
};
 
myFunction(); // window
 
var myProxyFunction = $.proxy( myFunction, myObject );
 
myProxyFunction(); // myObject
```

If you have an object with methods, you can pass the object and the name of a method to return a function that will always run in the scope of the object.
```js
var myObject = {
    myFn: function() {
        console.log( this );
    }
};
 
$( "#foo" ).click( myObject.myFn ); // HTMLElement #foo
$( "#foo" ).click( $.proxy( myObject, "myFn" ) ); // myObject
```

* 检测类型
Sometimes the typeof operator can be confusing or inconsistent, so instead of using typeof, jQuery offers utility methods to help determine the type of a value.

First of all, you have methods to test if a specific value is of a specific type.

```js
$.isArray([]); // true
$.isFunction(function() {}); // true
$.isNumeric(3.14); // true
```

Additionally, there is $.type() which checks for the internal class used to create a value. You can see the method as a better alternative for the typeof operator.

```js
$.type( true ); // "boolean"
$.type( 3 ); // "number"
$.type( "test" ); // "string"
$.type( function() {} ); // "function"
 
$.type( new Boolean() ); // "boolean"
$.type( new Number(3) ); // "number"
$.type( new String('test') ); // "string"
$.type( new Function() ); // "function"
 
$.type( [] ); // "array"
$.type( null ); // "null"
$.type( /test/ ); // "regexp"
$.type( new Date() ); // "date"
```

As always, you can check the [API docs](https://api.jquery.com/jQuery.type/) for a more in-depth explanation.