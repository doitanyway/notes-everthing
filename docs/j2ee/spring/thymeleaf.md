# thymeleaf模板介绍

* [简介](#简介)
* [基本使用](#基本使用)
* [知识重点](#知识重点)
* [代码示例](#代码示例)
* [总结](#总结)


## 简介  
* 本文主要是对thymeleaf模板介绍，归纳一些常用知识点


## 基本使用  
* spring boot后端  
    * Gradle方式，在build.gradle 里面的dependency加入以下配置：  
    ``
    compile "org.springframework.boot:spring-boot-starter-thymeleaf"  
    ``
    
    * maven加配置在pom.xml中  

    ```xml
     <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-thymeleaf</artifactId>
     </dependency>    
    ```  

    * 给Model.addAttribut赋值   

    ```java
      @RequestMapping("/user")  
      public String user(Model model){  
        User user = new User("nick","nick@qq.com");
        model.addAttribute("user", user);
        model.addAttribute("name", "elaine")；
        return "user";  
        }
    ```  
* 前端接收处理
   * html接收处理：  

     1.给html加入：`` <html xmlns:th="http://www.thymeleaf.org">``  
     2.用th:text来接收值，${xx}绑定yuans  
     ```javascript 
     <p th:text="'Hello, ' + ${name} + '!'" /> 
     ```  
* Vue变量接收处理  
  * 在script里添加：``th:inline="javascript"``  
    ```javascript
     <script th:inline="javascript">
    ```
  * 变量接收：``var name = [[${name}]]; ``  

## 知识重点  
前言：th：xxx 一般编译器报警告，我们可以用 `` data-th-xxx`` 代替，或引入
``<html xmlns:th="http://www.thymeleaf.org">`` ，推荐后者

### 常用的th标签与表达式

* 简单表达式  

   *  变量表达式  ${……} ,引用user对象的name属性值。 

   ```html
   <input type="text" name="userName" value="James Carrot" th:value="${user.name}" />
   ```  
  * 选择/星号表达式 *{……} ,  一般用在th:object后，直接选择object中的属性。  
  
  ```html
  <div th:object="${session.user}">                                               
     <p>Nationality: <span th:text="*{nationality}">XXXX</span>.</p> 
  </div>
  ```
  * #{...}  消息文字表达式   

  ```html
  <p th:utext="#{home.welcome}">Welcome to our grocery store!</p>
  ```
  * @{...}  链接url表达式  

  ```html
  <a href="details.html" th:href="@{/webPage/details(orderId=${o.id})}">view</a>
  ```  
* 常用th标签  

    * ``th:id`` 类似html标签中的id属性。 

    ```HTML
    <div class="student" th:id = "food+(${pizza.index}+1)"></div>
    ```  
    * ``th:href`` 动态引入静态资源：  

    ```css 
    <link rel="stylesheet" type="text/css" th:href="@{/static/css/public.css}"/>
    ```  
    * `` th:text``:  

    ```html
    <p th:text="#{home.welcome}">Welcome to our grocery store!</p>
    ```
    * ``th:utext:`` 用来转义空格等  

    ```html
    <p th:text="#{home.welcome}">Welcome to our grocery store!</p>
    ```  
    * ``th:object：`` 常与th:field一起使用进行表单数据绑定。选择表达式一般跟在th:object后，直接取object中的属性。  

    ```html
    <div th:object="${session.user}">
     <p>姓名：<span th:text="*{Name}">noodles</span></p>
     <p>年龄：<span th:text="*{age}">24</span></p>
     <p>国籍：<span th:text="*{nationlity}">中国</span></p>
    </div>
    ```  
    * ``th:action:`` 定义后台控制器路径，类似``<form>``标签的action属性。   

    ```html
    <form action="subscribe.html" th:action="@{/subscribe}">
    ```  
    * ``th：href:`` 定义超链接，类似``<a>``标签的href 属性  

    ```html
     <a href="details.html" 
     th:href="@{http://localhost:8080/gtvg/order/details(orderId=${o.id})}  ">view</a>
    ```   
    *  ``th：src:`` 用于外部资源引入，类似于``<script>``标签的src属性，常与@{}一起使用。  

    ```html
    <script th:src="@{/js/jquery/jquery-2.4.min.js}">
    ```   
    * ``th:if`` 条件判断,支持布尔值，数字   

    ```html
    <div th:if="${user.isAdmin()} == false">
    ```
## 代码示例： thymeleaf传值给后台
* 前端代码：  

    ```html
     <form  th:action="@{/greeting}"  method="GET">
       <p>姓名：<input type="text" name="name"  th:value="*{name}" />
       </p>
       <p>密码：<input type="password" name="password" th:value="*{password}"/>
       </p>
       <p><button>提交</button>
       </p>
     </form>
    ```  
    说明：``th:action="@{/greeting}"`` 指定后台注解“/greeting”，声明方法GET，  
          ``th:value="*{name}" `` 参数传值  
* 后端代码：  

    ```java
     ObjectMapper mapper = new ObjectMapper();  
     String json = "";  

     @RequestMapping(value = "/greeting",method = RequestMethod.GET)
     public String greeting(@RequestParam(value="name", required=false, defaultValue="World") String name,String password, Model model) throws JsonProcessingException {
            
            model.addAttribute("name", name); 
            Map<String, String>bjson =new HashMap<String, String>();
            bjson.put("pname", name);
            bjson.put("password", password);
            json = mapper.writeValueAsString(bjson);  
           
            System.out.println(json);
            return "greeting";
     }
    ```
   说明：``model.addAttribute("name", name); ``返回给前端绑定的name值，   
   对应前端：``<p th:text="'Hello, ' + ${name} + '!'" />``  
   ``String name,String password,``接收前端的传值,  
   对应前端：``th:value="*{name}",th:value="*{password}"``


## 总结
* thymeleaf模板便利了前后端传值，页面渲染,非常值得进一步学习。。。

  


