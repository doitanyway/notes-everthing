# 第一个jquery项目

## 第一个jquery项目

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Demo</title>
</head>
<body>
<a href="http://jquery.com/">jQuery</a>
<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.js"></script>

<script>
$(document).ready(function () {
    alert("hello you ");
});

</script>
</body>
</html>
```

## 给link加事件

```js
$( document ).ready(function() {
 
    $( "a" ).click(function( event ) {
 
        alert( "Thanks for visiting!" );
 
    });
 
});
```

## 阻止默认事件

```js
$(document).ready(function () {
    $("a").click(function (event) {
        alert("阻止默认事件.");
        event.preventDefault();
    })
});
```


## 添加、删除class

* 在head中加入style

```css
    <style>
        a.test {
            font-weight: bold;
        }
    </style>
```

* 添加和删除类

```JS
$("a").addClass("test");
$("a").removeClass("test");
```

## 效果

jquery可以给元素加一些效果。

```js
 $("a").click(function (event) {
        event.preventDefault();
        $(this).hide("slow");
    })
```
更多效果，可查看：https://api.jquery.com/category/effects/


## 回调函数(callback)

js不像其他语言，你可以绕过一个函数，等一会儿再执行。callback函数作为一个参数，等待前面一个特定的操作完成之后执行，同时浏览器可以做其他工作。

* 无参数的callback

```js
$.get( "myhtmlpage.html", myCallBack );
```

* 有参数的callback

```js
$.get( "myhtmlpage.html", function() {
    myCallBack( param1, param2 );
});
```
