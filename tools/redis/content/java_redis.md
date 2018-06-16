# 使用java连接redis

## 前言

本文介绍如何使用java 连接redis。使用 [jedis](https://github.com/xetorthio/jedis)。  

## 准备工作

* 新建一个java gradle项目；build.gradle内容如下；      
```
plugins {
    id 'java'
    id 'io.spring.dependency-management' version '1.0.1.RELEASE'
}

group 'org.nick'
version '1.0-SNAPSHOT'

sourceCompatibility = 1.8

repositories {
    mavenCentral()
}
dependencies {
    testCompile group: 'junit', name: 'junit', version: '4.12'                               //
    compile group: 'org.apache.logging.log4j', name: 'log4j-api', version: '2.11.0'  
    compile group: 'ch.qos.logback', name: 'logback-classic', version: '1.2.3'               //日志依赖
    compile group: 'redis.clients', name: 'jedis', version: '2.9.0'                          //jedis依赖
}
```


## 简单测试

如下新建了一个jedis连接，并写入一个字符串。

```java
public class RedisBasic {
    private static Logger logger = LoggerFactory.getLogger(RedisBasic.class);

    public static void main(String[] args) {
        logger.info("start test.{}", args.length);
        Jedis jedis = new Jedis("192.168.1.222", 6379);
        jedis.set("name", "nick");
        String value = jedis.get("name");
        logger.info("get name:{}", value);
        jedis.close();
    }
}
```


## JedisPool的使用

如下配置新建了要给JedisPool连接池，并做了一系列读写操作。

```java
public class RedisPool {
    private static Logger logger = LoggerFactory.getLogger(RedisPool.class);

    JedisPool pool ;

    private void init(){
        pool = new JedisPool();
        JedisPoolConfig jedisPoolConfig = new JedisPoolConfig();
        // 设置最大10个连接
        jedisPoolConfig.setMaxTotal(500);
        jedisPoolConfig.setMaxIdle(500);
        jedisPoolConfig.setMinIdle(30);
        jedisPoolConfig.setMaxWaitMillis(1000*60);
        pool = new JedisPool(jedisPoolConfig, "192.168.1.222",6379);
        logger.info("init connection success. ");
    }
    public void testPing(){
        // Jedis 实现了java.lang.AutoCloseable接口,所以这里可以用java 1.7 try-with-resources语法自动完成close
        try(Jedis jedis = pool.getResource()){
            //查看服务是否运行 PING
            logger.info("try ping: {}",jedis.ping());
        }
    }
    public void testString(){
        try(Jedis jedis = pool.getResource()){
            jedis.set("test_name", "thiis is a 字符");
            logger.info("redis test_name:{} ", jedis.get("test_name"));
        }
    }
    public void testList() {
        try (Jedis jedis = pool.getResource()) {
            // 选择数据库:  SELECT 2
            jedis.select(2);
            // 存储数据到列表中
            // LPUSH
            jedis.lpush("class_list", "语文");
            jedis.lpush("class_list", "english");

            // 获取存储的数据并输出: LRANGE phone_list 0 2
            List<String> list = jedis.lrange("class_list", 0, 1);
            for (int i = 0; i < list.size(); i++) {
                logger.info("class_list:{} " , list.get(i));
            }
        }
    }
    public void close(){
        if(null != pool){
            pool.destroy();
            logger.info("destroy the pool");
        }
    }

    public static void main(String[] args) {
        RedisPool redisPool = new RedisPool();
        redisPool.init();
        redisPool.testPing();
        redisPool.testString();
        redisPool.testList();
        redisPool.close();
    }
}
```