# context:property-placeholder

## 说明

1. 有些参数在某些阶段中是常量  
    * 在开发阶段我们连接数据库时的连接url，username，password，driverClass等 
    * 分布式应用中client端访问server端所用的server地址，port，service等  
    * 配置文件的位置
1. 而这些参数在不同阶段之间又往往需要改变
    比如：在项目开发阶段和交付阶段数据库的连接信息往往是不同的，分布式应用也是同样的情况。

期望：能不能有一种解决方案可以方便我们在一个阶段内不需要频繁书写一个参数的值，而在不同阶段间又可以方便的切换参数配置信息  
解决：spring3中提供了一种简便的方式就是context:property-placeholder/元素

## 方法

只需要在spring的配置文件里添加一句：``<context:property-placeholder location="classpath:jdbc.properties"/> ``即可，这里location值为参数配置文件的位置，参数配置文件通常放在src目录下，而参数配置文件的格式跟java通用的参数配置文件相同，即键值对的形式，例如：

```properties
#jdbc配置
test.jdbc.driverClassName=com.mysql.jdbc.Driver
test.jdbc.url=jdbc:mysql://localhost:3306/test
test.jdbc.username=root
test.jdbc.password=root
```

这样一来就可以为spring配置的bean的属性设置值了，比如spring有一个jdbc数据源的类DriverManagerDataSource
在配置文件里这么定义bean：
```xml
<bean id="testDataSource" class="org.springframework.jdbc.datasource.DriverManagerDataSource">
    <property name="driverClassName" value="${test.jdbc.driverClassName}"/>
    <property name="url" value="${test.jdbc.url}"/>
    <property name="username" value="${test.jdbc.username}"/>
    <property name="password" value="${test.jdbc.password}"/>
</bean>
```