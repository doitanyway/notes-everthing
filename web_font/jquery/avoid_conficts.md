# 避免冲突

## 创建一个别名


```js
<!-- Putting jQuery into no-conflict mode. -->
<script src="prototype.js"></script>
<script src="jquery.js"></script>
<script>
 
var $j = jQuery.noConflict();
// $j is now an alias to the jQuery function; creating the new alias is optional.
 
$j(document).ready(function() {
    $j( "div" ).hide();
});
 
// The $ variable now has the prototype meaning, which is a shortcut for
// document.getElementById(). mainDiv below is a DOM element, not a jQuery object.
window.onload = function() {
    var mainDiv = $( "main" );
}
 
</script>
```

## 在其他包之前加jquery

```js
<!-- Loading jQuery before other libraries. -->
<script src="jquery.js"></script>
<script src="prototype.js"></script>
<script>
 
// Use full jQuery function name to reference jQuery.
jQuery( document ).ready(function() {
    jQuery( "div" ).hide();
});
 
// Use the $ variable as defined in prototype.js
window.onload = function() {
    var mainDiv = $( "main" );
};
 
</script>
```

## 使用内部调用

```js
<!-- Using the $ inside an immediately-invoked function expression. -->
<script src="prototype.js"></script>
<script src="jquery.js"></script>
<script>
 
jQuery.noConflict();
 
(function( $ ) {
    // Your jQuery code here, using the $
})( jQuery );
 
</script>
```


## 使用参数传递jquery函数

```js
<script src="jquery.js"></script>
<script src="prototype.js"></script>
<script>
 
jQuery(document).ready(function( $ ) {
    // Your jQuery code here, using $ to refer to jQuery.
});
 
</script>
```

简化模式：

```js
<script src="jquery.js"></script>
<script src="prototype.js"></script>
<script>
 
jQuery(function($){
    // Your jQuery code here, using the $
});
 
</script>
```