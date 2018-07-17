**MQ如果用于日志管理，往往在调用日志service之后就要使用消息队列发送消息给日志服务器。这个是一个重复且高度一致的处理逻辑，我们可以使用AOP**
# 1.springAOP依赖
```
<!-- AOP -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-aop</artifactId>
</dependency>
```
# 2.编写切面类
```
/声明切面
@Component
@Aspect
public class CatalogAop {
    //在引入Spring-AMQP后可以直接使用AmqpTemplate
    @Autowired
    private AmqpTemplate rabbitTemplate;

    //使用@AfterReturning并声明切点表达式
    @AfterReturning(value="execution(* an.catalog.CatalogService.editCatalog(..))" , returning="result")
    public void doAccessCheck(JoinPoint joinPoint , Object result) {
        //组装要发送的消息内容
        Object[] args = joinPoint.getArgs();
        Long catalogId = (Long) args[0];
        String name = (String) args[1];
        String model = (String) args[2];
        String unit = (String) args[3];
        Boolean unique = (Boolean) args[4];
        Boolean parent = (Boolean) args[5];
        //在这个理模拟一个日志DTO
        Catalog catalog = new Catalog(catalogId, name, model, unit, unique, parent);
        //由于editCatalog正常执行的返回值是void，所以如果返回为null说明成功执行，可以开始发送消息，如果失败则什么都不发送
        if(result == null) {
        //使用已封装好的convertAndSend(String exchange , String routingKey , Object message)使用特定的routingKey发送消息到指定的exchange
            rabbitTemplate.convertAndSend("catalogExchange" , "editCatalogKey" , JSON.toJSONString(catalog));
        }
    }
}
```
# 3.使用反射注解，捕捉切点信息