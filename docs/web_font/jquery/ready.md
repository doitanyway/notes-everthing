# $( document ).ready()

一个页面不能被安全的维护，直到ready。jquery通过$( document ).ready()检测dom的状态,如下代码。

```js
// A $( document ).ready() block.
$( document ).ready(function() {
    console.log( "ready!" );
});
```

有经验的程序员经常使用如下简写的方式。

```js
// Shorthand for $( document ).ready()
$(function() {
    console.log( "ready!" );
});
```

