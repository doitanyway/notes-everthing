# redis高可用java连接

##  前言

本文介绍如何使用java连接高可用redis哨兵。


## 代码 

```gradle
group 'org.nick'
version '1.0-SNAPSHOT'

apply plugin: 'java'
sourceCompatibility = 1.8
repositories {
    mavenCentral()
}
dependencies {
    testCompile group: 'junit', name: 'junit', version: '4.12'
    compile group: 'org.apache.logging.log4j', name: 'log4j-api', version: '2.11.0'
    compile group: 'ch.qos.logback', name: 'logback-classic', version: '1.2.3'               //日志依赖
    compile group: 'redis.clients', name: 'jedis', version: '2.9.0'                          //jedis依赖
}
```

```java
public class RedisSentinelFailoverTest {

    private static Logger logger = LoggerFactory.getLogger(RedisSentinelFailoverTest.class);

    public static void main(String[] args) throws InterruptedException {
        GenericObjectPoolConfig config =new GenericObjectPoolConfig();
        config.setMaxTotal(2000);
        config.setMaxIdle(500);
        config.setTestOnBorrow(false);
        config.setTestOnReturn(false);
        config.setBlockWhenExhausted(true);

        Set<String> sentinels = new HashSet<String>();
        sentinels.add("192.168.3.52:26379");
        sentinels.add("192.168.3.52:26380");
        sentinels.add("192.168.3.52:26381");
        JedisSentinelPool jedisSentinelPool = new JedisSentinelPool("mymaster", sentinels,config);
        Jedis jedis = null;
        int errorCount = 0;
        while (true) {
            try {
                jedis = jedisSentinelPool.getResource();

                Date now = new Date();
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                String format_now = dateFormat.format(now);
                jedis.set("hello", "world");
                logger.info("get hello = {} ",jedis.get("hello"));
                TimeUnit.MILLISECONDS.sleep(1000);
                errorCount = 0;
            } catch (Exception e) {
                errorCount++ ;
                logger.info("Error {} seconds",errorCount);
                TimeUnit.MILLISECONDS.sleep(1000);
            } finally {
                if (jedis != null)
                    try {
                        jedis.close();
                    } catch (Exception e) {
                        System.out.println(e);
                    }
            }
        }
    }

}
```

## 测试

可进入服务器，杀死mast进程或者slave进程，可观察到，服务器等一段时间就恢复了。
