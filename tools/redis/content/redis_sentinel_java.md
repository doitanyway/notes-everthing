# redis高可用java连接

##  前言

本文介绍如何使用java连接高可用redis哨兵。


## 代码 

```java
public class RedisSentinelFailoverTest {

    private static Logger logger = LoggerFactory.getLogger(RedisSentinelFailoverTest.class);

    public static void main(String[] args) throws InterruptedException {
        Set<String> sentinels = new HashSet<String>();
        sentinels.add("192.168.3.52:26379");
        sentinels.add("192.168.3.52:26380");
        sentinels.add("192.168.3.52:26381");
        JedisSentinelPool jedisSentinelPool = new JedisSentinelPool("mymaster", sentinels);
        Jedis jedis = null;
        while (true) {
            try {
                jedis = jedisSentinelPool.getResource();

                Date now = new Date();
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                String format_now = dateFormat.format(now);

                jedis.set("hello", "world");
                String value = jedis.get("hello");
                System.out.println(format_now + ' ' + value);
                TimeUnit.MILLISECONDS.sleep(1000);
            } catch (Exception e) {
                System.out.println(e);
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
