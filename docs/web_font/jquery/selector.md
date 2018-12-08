# 选择器

最基础的操作莫过于选择某个元素，然后对该元素做一些操作，本文介绍如何选择元素；

## 通过id选择

```js
$("#myId"); // Note IDs must be unique per page.
```

## 通过类名选择

```js
$(".className");
```

## 通过属性选择

```js
$("input[name='first_name']");
```

## Selecting Elements by Compound CSS Selector

```js
$( "#contents ul.people li" );
```

## 用都好选择多个元素

```js
$( "div.myClass, ul.people" );
```

## link Pseudo-Selectors

```js
$( "a.external:first" );
$( "tr:odd" );
 
// Select all input-like elements in a form (more on this below).
$( "#myForm :input" );
$( "div:visible" );
 
// All except the first three divs.
$( "div:gt(2)" );
 
// All currently animated divs.
$( "div:animated" );
```


##  选择合适的选择器

选择器尽量简练，一个选择器如一个选择器如果``#myTable th.special``能满足要求，就千万别使用``#myTable thead tr th.special``。

### 判断一个选择器是否有元素

```js
// Testing whether a selection contains elements.
if ( $( "div.foo" ).length ) {
    ...
}
```

### 保存selector

```js
var divs = $( "div" );
```

### 在选择器之后再筛选

一些选择器包含了一些你不想要的元素，jquery提供了一些方法可以筛选元素。

```js
// Refining selections.
$( "div.foo" ).has( "p" );         // div.foo elements that contain <p> tags
$( "h1" ).not( ".bar" );           // h1 elements that don't have a class of bar
$( "ul li" ).filter( ".current" ); // unordered list items with class of current
$( "ul li" ).first();              // just the first unordered list item
$( "ul li" ).eq( 5 );              // the sixth
```

### 根据状态选择

* 选择属性是checked的checkbox和radio buttons（``<select>``是``selected ``）

```js
$( "form :checked" );
```

* 选择有`` disabled``的<input>元素:

```js
$( "form :disabled" );
```
```js
$( "form :enabled" );
```

* :input selector selects all <input>, <textarea>, <select>, and <button> elements:

```js
$( "form :input" );
```

* Using the :selected pseudo-selector targets any selected items in <option> elements:

```js
$( "form :selected" );
```

* 通过类型选择

```js
:password
:reset
:radio
:text
:submit
:checkbox
:button
:image
:file
```
更多内容，可查看“https://api.jquery.com/category/selectors/form-selectors/”。
