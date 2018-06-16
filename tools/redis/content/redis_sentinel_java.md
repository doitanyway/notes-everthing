# redis高可用java连接

##  前言

本文介绍如何使用java连接高可用redis哨兵。


## 代码 还未测试通过
有没有可能是redis太新了不兼容？
https://lanjingling.github.io/2015/12/29/redis-sentinel-jedis-shizhan/

```java
public class RedisSentinelFailoverTest {
    private static Logger logger = LoggerFactory.getLogger(RedisSentinelFailoverTest.class);
    public static  void main(String [] args){
        Set<String> sentinels = new HashSet<String>();
        sentinels.add("192.168.1.222:26379");
        sentinels.add("192.168.1.222:26380");
        sentinels.add("192.168.1.222:26381");

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