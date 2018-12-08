# Attributes

元素的属性在我们的应用中包含有用的信息，因此能够读取和设置属性是相当重要的。

## ``.attr``方法

这个方法既是get也是set方法，它能接受一个key和value，也能接受一个对象容器设置多个key

** ``.attr``用作setter

```js
$( "a" ).attr( "href", "allMyHrefsAreTheSameNow.html" );
 
$( "a" ).attr({
    title: "all titles are the same too!",
    href: "somethingNew.html"
});
```

** ``.attr``用作getter

```js
$( "a" ).attr( "href" ); // Returns the href for the first a element in the document
```