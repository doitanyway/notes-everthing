## service的服务发现

### 前言

服务发现分为2种，环境变量和dns


* 环境变量，当一个pod运行到node,kubect会为每个容器添加一组环境变量，pod容器中程序就可以通过这些变量发现service，环境变量格式如下：
  * [SVCNAME]_SERVICE_HOST
  * [SVCNAME]_SERVICE_PORT   
  限制： 
  * pod和service的创建是有顺序要求的，service必须在pod创建之前创建，否则环境变量不会被设置到pod中
  * pod只能获取同一个namespace的service环境变量；

* DNS服务监视kubernetes API,为每个Service创建DNS记录用于域名解析，这样pod中就可以通过DNS域名获取service的访问地址；


  