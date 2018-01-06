# CSS, Styling, & Dimensions

jQuery有一种很简单的获取CSS属性的方法：   

```js
// Getting CSS properties.
$( "h1" ).css( "fontSize" ); // Returns a string such as "19px".
 
$( "h1" ).css( "font-size" ); // Also works.
```

```js
// Setting CSS properties.
 
$( "h1" ).css( "fontSize", "100px" ); // Setting an individual property.
 
// Setting multiple properties.
$( "h1" ).css({
    fontSize: "100px",
    color: "red"
});
```

CSS属性在js中通常是小驼峰命名法，如CSS属性``font-size``是``fontSize``,但是通过``.css``方法传递的时候两种方法都能工作。  
不推荐使用css方法作为setter，但是传递修对象去设置CSS的时候，CSS属性需要时小驼峰命名。

## 使用css class

```js
// Working with classes.
 
var h1 = $( "h1" );
 
h1.addClass( "big" );
h1.removeClass( "big" );
h1.toggleClass( "big" );
 
if ( h1.hasClass( "big" ) ) {
    ...
}
```

## 尺寸

```js 
// Basic dimensions methods.
 
// Sets the width of all <h1> elements.
$( "h1" ).width( "50px" );
 
// Gets the width of the first <h1> element.
$( "h1" ).width();
 
// Sets the height of all <h1> elements.
$( "h1" ).height( "50px" );
 
// Gets the height of the first <h1> element.
$( "h1" ).height();
 
 
// Returns an object containing position information for
// the first <h1> relative to its "offset (positioned) parent".
$( "h1" ).position();
```