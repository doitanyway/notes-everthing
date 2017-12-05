# HttpServletResponse对象

## Http响应

* 格式：
```
响应（服务器—>浏览器）
HTTP/1.1 200 OK     --响应行
Server: Apache-Coyote/1.1   --响应头（key-value）
Content-Type: text/html;charset=utf-8
Content-Length: 17
Date: Wed, 16 Nov 2016 07:16:46 GMT
                            --一个空行
this is a Servlet           --实体内容
```

* 响应行 
```
1）http协议版本：同请求行 
2）状态码: 服务器处理请求的结果（状态） 
```

* 常见的状态： 
a）200 ： 表示请求处理完成并完美返回 
b）302： 表示请求需要进一步细化。 
c）404： 表示客户访问的资源找不到。 
d）500： 表示服务器的资源发送错误。（服务器内部错误） 

* 常见响应头
```
Location: http://www.it315.org/index.jsp   --表示重定向的地址，该头和302的状态码一起使用。
Server:apache tomcat                 --表示服务器的类型
Content-Encoding: gzip               --表示服务器发送给浏览器的数据压缩类型
Content-Length: 80                   --表示服务器发送给浏览器的数据长度
Content-Language: zh-cn              --表示服务器支持的语言
Content-Type: text/html; charset=GB2312   --表示服务器发送给浏览器的数据类型及内容编码
Last-Modified: Tue, 11 Jul 2000 18:23:51 GMT  --表示服务器资源的最后修改时间
Refresh: 1;url=http://www.it315.org     --表示定时刷新
Content-Disposition: attachment; filename=aaa.zip --表示告诉浏览器以下载方式打开资源（下载文件时用到）
Transfer-Encoding: chunked
Set-Cookie:SS=Q0=5Lb_nQ; path=/search   --表示服务器发送给浏览器的cookie信息（会话管理用到）
Expires: -1                           --表示通知浏览器不进行缓存
Cache-Control: no-cache
Pragma: no-cache
Connection: close/Keep-Alive           --表示服务器和浏览器的连接状态。close：关闭连接 keep-alive:保存连接
```

## HttpServletResponse对象 

* HttpServletResponse对象作用：修改响应信息。

* 响应行： 
    * response.setStatus() 设置状态码 
    * response.sendError() 设置状态码，调用默认对应页面 
    * response.setHeader(“name”,”value”) 设置响应头 
    * 实体内容： response.getWriter().writer(); 发送字符实体内容 ，response.getOutputStream().writer() 发送字节实体内容 

## 完整代码及HttpServletResponse开发流程详解


```java
package sram.response;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ResponseDemo1 extends HttpServlet {
    /**
     * 1)tomcat服务器把请求信息封装到HttpServletRequest对象，且把响应信息封装到HttpServletResponse
     * 2）同样tomcat服务器先调用service方法，service方法调用doGet方法，传入request，和response对象。详解见博客HttpServletRequest对象
     */
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        /**
         * 3）通过response对象改变响应信息
         */
        /**
         * 3.1 响应行
         */
        //response.setStatus(404);//修改状态码
        //response.sendError(404); // 发送404的状态码+404的错误页面
        /**
         * 3.2 响应头
         */
        response.setHeader("server", "JBoss");
        /**
         * 3.3 实体内容(浏览器直接能够看到的内容就是实体内容)
         */
        //response.getWriter().write("This is a HttpServletResponse"); //字符内容。
        response.getOutputStream().write("This is a HttpServletResponse".getBytes());//字节内容
    }
    /**
     * 4)tomcat服务器把response对象的内容转换成响应格式内容，再发送给浏览器解析。
     */
}
```
