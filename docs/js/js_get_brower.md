# js获取当打开浏览器

代码如下图：  

```js
	if (/MicroMessenger/.test(window.navigator.userAgent)) { 
		alert('微信客户端'); 
	} else if (/AlipayClient/.test(window.navigator.userAgent)) { 
		alert('支付宝客户端');
	} else {
		alert('其他浏览器');
	}
```