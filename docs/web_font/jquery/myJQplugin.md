# jq自定义插件  

jq插件，即学即用  

## 新建插件  

* 先创建一个允许使用美元符号($)的包装器函数  
    ```javascript
    (function($) {
    ......
    })(jQuery);
    ```  

* 使用fn属性创建一个新jQuery插件,为fn属性分配一个插件名，并将其指向一个函数  
    ```javascript
    (function($) {
        $.fn.xwzPlugin = function() { //定义插件的名称，这里为xwzPlugin
        
        }  
    })(jQuery);  
    ```  

* 这里我们新建一个版权插件  
    ```javascript
    (function($) {
        $.fn.xwzPlugin = function(options) { //插件称xwzPlugin
                var dft = {
                //以下为该插件的属性及其默认值
                cpBy: "xwz", //版权所有者
                url: "http://www.xwzCode.com", //所有者链接
                size: "12px", //版权文字大小
                align: "left" //版权文字位置，left || center || right
            };
            var ops = $.extend(dft,options);
            var style = 'style="font-size:' + ops.size + ';text-align:' + ops.align + ';"'; //调用默认的样式
            var cpTxt = '<p' + ' ' + style + '>此文章版权归<a target="_blank" href="' + ops.url + '">' + ops.cpBy + '</a>所有</p>'; //生成版权文字的代码
            $(this).append(cpTxt); //把版权文字加入到想显示的div
        }  
    })(jQuery);  
    ```  
## 插件使用  

* 在页面HTML里指定标签如：  
```html
<div id="article-content" style="height: 50px;width: 200px">使用xwzPlugin</div> 
```  

* 在JS里无参调用
    ```javascript
    <scripttype="text/javascript">
    $("#article-content").xwzPlugin();
    <script">
    ```  
* 有参调用  
    ```javascript
	$("#article-content").xwzPlugin({
		cpBy: " T "
	});
    ```  

