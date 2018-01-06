# 传递


## Parents

找到父亲，节点的方法包括.parent(), .parents(), .parentsUntil(), and .closest().
```html
<div class="grandparent">
    <div class="parent">
        <div class="child">
            <span class="subchild"></span>
        </div>
    </div>
    <div class="surrogateParent1"></div>
    <div class="surrogateParent2"></div>
</div>
```

```js
// Selecting an element's direct parent:
 
// returns [ div.child ]
$( "span.subchild" ).parent();
 
// Selecting all the parents of an element that match a given selector:
 
// returns [ div.parent ]
$( "span.subchild" ).parents( "div.parent" );
 
// returns [ div.child, div.parent, div.grandparent ]
$( "span.subchild" ).parents();
 
// Selecting all the parents of an element up to, but *not including* the selector:
 
// returns [ div.child, div.parent ]
$( "span.subchild" ).parentsUntil( "div.grandparent" );
 
// Selecting the closest parent, note that only one parent will be selected
// and that the initial element itself is included in the search:

// returns [ div.child ]
$( "span.subchild" ).closest( "div" );
// returns [ div.child ] as the selector is also included in the search:
$( "div.child" ).closest( "div" );
```

## Children

找儿子，方法有``.children()``,``.find()``,这两个函数的不同点在于查找多深，children只找下一级，find会一直到底。

```js
// Selecting an element's direct children:
// returns [ div.parent, div.surrogateParent1, div.surrogateParent2 ]
$( "div.grandparent" ).children( "div" );
// Finding all elements within a selection that match the selector:
// returns [ div.child, div.parent, div.surrogateParent1, div.surrogateParent2 ]
$( "div.grandparent" ).find( "div" );
```


## Siblings

找兄弟，前一个``.prev()``，后一个``.next()``,两边一起找``.siblings()``，还有一些方法在上面这些方法基础上建立起来，下面我们来看看用法 ：  

```js
// Selecting a next sibling of the selectors:
 
// returns [ div.surrogateParent1 ]
$( "div.parent" ).next();
 
// Selecting a prev sibling of the selectors:
 
// returns [] as No sibling exists before div.parent
$( "div.parent" ).prev();
 
// Selecting all the next siblings of the selector:
 
// returns [ div.surrogateParent1, div.surrogateParent2 ]
$( "div.parent" ).nextAll();
 
// returns [ div.surrogateParent1 ]
$( "div.parent" ).nextAll().first();
 
// returns [ div.surrogateParent2 ]
$( "div.parent" ).nextAll().last();
 
// Selecting all the previous siblings of the selector:
 
// returns [ div.surrogateParent1, div.parent ]
$( "div.surrogateParent2" ).prevAll();
 
// returns [ div.surrogateParent1 ]
$( "div.surrogateParent2" ).prevAll().first();
 
// returns [ div.parent ]
$( "div.surrogateParent2" ).prevAll().last(); 
```

``.siblings()``:  

```js
// Selecting an element's siblings in both directions that matches the given selector:
 
// returns [ div.surrogateParent1, div.surrogateParent2 ]
$( "div.parent" ).siblings();
 
// returns [ div.parent, div.surrogateParent2 ]
$( "div.surrogateParent1" ).siblings();
```

完整的介绍，请看[官方API文档](https://api.jquery.com/category/traversing/tree-traversal/)
