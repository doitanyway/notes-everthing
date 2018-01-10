# flexbox

本文简要介绍了flexbox的使用，详细内容可以查看下面两个网站： 
https://css-tricks.com/snippets/css/a-guide-to-flexbox/
https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Flexible_Box_Layout/Basic_Concepts_of_Flexbox


## 属性

* 容器属性

    * display: flex; /* or inline-flex */
    * flex-direction: row | row-reverse | column | column-reverse;
    * flex-wrap: nowrap | wrap | wrap-reverse;
    * flex-flow (Applies to: parent flex container element)
    * justify-content: flex-start | flex-end | center | space-between | space-around | space-evenly;
    * align-items: flex-start | flex-end | center | baseline | stretch;
    * align-content: flex-start | flex-end | center | space-between | space-around | stretch;

*  元素属性

    * order: <integer>; /* default is 0  元素排序 */
    * flex-grow: <number>; /* default 0 1填充满剩余行*/
    * flex-shrink: <number>; /* default 1 必要时搜索*/
    * flex-basis: <length> | auto; /* default auto */
    * flex: none | [ <'flex-grow'> <'flex-shrink'>? || <'flex-basis'> ]
    * align-self: auto | flex-start | flex-end | center | baseline | stretch;  /*该元素的对其方式*/
    * 元素属性简写： flex: none | [ <'flex-grow'> <'flex-shrink'>? || <'flex-basis'> ]


## 例子

```css
.parent {
  display: flex;
  height: 300px; /* Or whatever */
}

.child {
  width: 100px;  /* Or whatever */
  height: 100px; /* Or whatever */
  margin: auto;  /* Magic! */
}
```

* 例子2： https://codepen.io/team/css-tricks/pen/EKEYob

![](assets/2018-01-09-15-08-57.png)

* 例子3：https://codepen.io/team/css-tricks/pen/YqaKYR

![](assets/2018-01-09-15-09-36.png)

* 例子4：https://codepen.io/chriscoyier/pen/vWEMWw 

![](assets/2018-01-09-15-10-31.png)

