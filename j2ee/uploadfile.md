# java接收上传文件

## 简介

本文介绍JAVA如何实现文件的上传

## 客户端请求

使用POST命令格式是``multipart/form-data``,示例如下：

```
POST /URPCSF0008.0/wxtag/v1.00/certification HTTP/1.1
Host: 192.168.1.244:10001
Authorization: Bearer 6gbpocsv7tind6vgksoa2tpbtnn5cxt1stgy3mau7uy1bhjjb5zgpp2opkwi5qrm
Cache-Control: no-cache
Postman-Token: 1ecb96f7-98ae-dab6-daea-c567d6a79857
Content-Type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW

------WebKitFormBoundary7MA4YWxkTrZu0gW
Content-Disposition: form-data; name="plateNumber"

粤B12345
------WebKitFormBoundary7MA4YWxkTrZu0gW
Content-Disposition: form-data; name="phone"

18000000001
------WebKitFormBoundary7MA4YWxkTrZu0gW
Content-Disposition: form-data; name="idCard"; filename="1.jpeg"
Content-Type: image/jpeg


------WebKitFormBoundary7MA4YWxkTrZu0gW--
```

## 服务器配置

* servlet 配置  
```xml
   	<servlet>
    	<servlet-name>certification</servlet-name>
    	<servlet-class>com.fangle.urpcs.wxtag.control.WxtagCertificationController</servlet-class>
    	<multipart-config/>
   	</servlet>
   	<servlet-mapping>
    	<servlet-name>certification</servlet-name>
    	<url-pattern>/wxtag/v1.00/certification</url-pattern>
   	</servlet-mapping>
```
* servlet 类

```java
@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		LOGGER.info("call "+request.getRequestURL());
        
		Part plateNumber=request.getPart("plateNumber");
		Part phone=request.getPart("phone");
		Part idCard = request.getPart("idCard");
		LOGGER.info(idCard.getName());
		
		long fileSizeLimit = 1024 * 1024 * 1024;

		LOGGER.info("idCard.getSize()="+idCard.getSize());
		if (idCard.getSize() > fileSizeLimit) {
			response.setStatus(HttpServletResponse.SC_REQUEST_ENTITY_TOO_LARGE);
			return;
		}

		File tempFile = new File("./idCard.jpeg") ;//TempFileUtils.createTempFile();
		FileOutputStream fileOutputStream = new FileOutputStream(tempFile);
		try {
			IOUtils.copy(idCard.getInputStream(), fileOutputStream);
		} finally {
			fileOutputStream.flush();
			fileOutputStream.close();
		}
		response.setStatus(HttpServletResponse.SC_OK);
	}
```

