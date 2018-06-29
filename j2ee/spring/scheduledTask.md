# 计划任务 {ignore=true}


## 简介
计划任务：主要处理定时任务

## 操作步骤  
* 单线程10s后间隔10s循环执行  

```java
Runnable runnable = new Runnable() {    
    public void run() {    
         // task to run goes here    
         System.out.println("Hello !!");    
    }    
}; 
```  

```java  
//newSingleThreadScheduledExecutor单线程执行
 
ScheduledExecutorService service = Executors    
                .newSingleThreadScheduledExecutor();    
// 第二个参数为首次执行的延时时间，第三个参数为定时执行的间隔时间,TimeUnit.SECONDS:时间单位为秒，TimeUnit.MINUTES：单位为分钟,TimeUnit.HOURS：单位为小时,TimeUnit.DAYS:单位为天
service.scheduleAtFixedRate(runnable, 10, 10, TimeUnit.SECONDS);   
```  
* 新建TaskJob,在main函数里执行，5s后执行一次  

```java
public class TaskJob implements Runnable{
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");  
	    public void run() {  
	        try {  
	            Thread.sleep(5000);  
	        } catch (InterruptedException ex) {  
	            ex.printStackTrace();  
	        }  
	    System.out.println("do something  at:" + sdf.format(new Date()));  
	} 
}
```  
main函数里调用  

```java
ScheduledExecutorService servicepool = Executors.newScheduledThreadPool(5);    
final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");  
System.out.println(" begin to do something at:" + sdf.format(new Date()));  
servicepool.schedule((Runnable) new TaskJob(),1, TimeUnit.SECONDS);  
```  
## 总结  

### ScheduledExecutorService使用说明  

* 创建了ScheduledExecutorService的实例，可以使用下面一些方法：  
  * schedule (Callable task, long delay, TimeUnit timeunit)
  * schedule (Runnable task, long delay, TimeUnit timeunit)
  * scheduleAtFixedRate (Runnable, long initialDelay, long period, TimeUnit timeunit)
  * scheduleWithFixedDelay (Runnable, long initialDelay, long period, TimeUnit timeunit)  
  //ScheduleAtFixedRate 是基于固定时间间隔进行任务调度,每次执行时间为上一次任务开始起向后推一个时间间隔;  
  //ScheduleWithFixedDelay 取决于每次任务执行的时间长短,每次执行时间为上一次任务结束起向后推一个时间间隔.
* ScheduleExecutorService使用shutdown()和shutdownNow()结束任务  

```java
ScheduledExecutorService scheduledExecutorService = Executors.newScheduledThreadPool(5);

ScheduledFuture<?> scheduledFuture = scheduledExecutorService.schedule(new Callable<Object>() {
                public Object call() throws Exception {
                    System.out.println("Executed!");
                    return "Called!";
                }
            },
            5,
            TimeUnit.SECONDS);

System.out.println("result = " + scheduledFuture.get());

scheduledExecutorService.shutdown();
```
