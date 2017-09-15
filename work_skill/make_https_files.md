# 制作HTTPS证书

## 简要说明
本文介绍如何生成HTTPS整数，并配置HTTPS证书

## 准备工作

* 操作电脑需要安装JDK1.7及以上版本
* 安装好的tomcat服务器


## 操作步骤

* 系统安装JDK并设置好环境变量；

* 使用keytool为tomcat生成证书;
```
keytool -genkey -v -alias tomcat -keyalg RSA -keystore tomcat.keystore -validity 36500
```
* 为客户端生成证书;
```
keytool -genkey -v -alias huawei -keyalg RSA -storetype PKCS12 -keystore huaweitest.p12 -validity 36500
```

* 将huaweitest.p12导入到tomcat的信任证书链中
```
keytool -export -alias huawei -keystore huaweitest.p12 -storetype PKCS12 -rfc -file huaweitest.cer
keytool -import -alias huawei -v -file huaweitest.cer -keystore tomcat.keystore
```

* 从tomcat的证书链里导出根证书
```
keytool -export -v -alias tomcat -file CA.cer -keystore tomcat.keystore
```

* 将华为IOT提供的outgoing.CertwithKey.pem导入tomcat的信任证书链
```
keytool -import -v -file outgoing.CertwithKey.pem -alias huawei_outgoing -keystore tomcat.keystore
```

* 将华为IOT提供的ca.pem导入tomcat的信任证书链
```
keytool -import -v -file ca.pem -alias huawei_ca -keystore tomcat.keystore
```

* 在服务器上进行格式转换成pem格式
```
openssl x509 -inform der -in CA.cer -out ca.pem
```

* 把根证书tomcat.keystore拷贝到/conf/keys/目录下

* 配置tomcat
单向认证，修改server.xml：
```
protocol="org.apache.coyote.http11.Http11NioProtocol"
scheme="https" secure="true"
keystoreFile="conf/keys/tomcat.keystore" keystorePass="制作证书时的密码"
clientAuth="false" sslProtocol="TLS"
maxThreads="150" SSLEnabled="true">
```

* 配置完后，可以验证配置是否成功。
单向认证模拟建链：  
本地验证
```
openssl s_client -connect 127.0.0.1:8688 -tls1 -CAfile ca.pem
```
外网验证（拷贝ca.pem证书到外网的其他服务器） 

```
openssl s_client -connect TOMCAT服务器IP:端口 -tls1 -CAfile ca.pem
```

* 验证通过，把ca.pem发给华为IOT的人上传到IOT系统。





## 其他

keytool参数详解.txt

-genkey    在用户主目录中创建一个默认文件".keystore",还会产生一个mykey的别名，mykey中包含用户的公钥、私钥和证书  
-alias     产生别名  
-keystore  指定密钥库的名称(产生的各类信息将不在.keystore文件中  
-keyalg    指定密钥的算法    
-validity  指定创建的证书有效期多少天  
-keysize   指定密钥长度  
-storepass 指定密钥库的密码  
-keypass   指定别名条目的密码  
-dname     指定证书拥有者信息 例如：  
            "CN=sagely,OU=atr,O=szu,L=sz,ST=gd,C=cn"  
-list      显示密钥库中的证书信息  
            keytool -list -v -keystore sage -storepass ....  
-v         显示密钥库中的证书详细信息  
-export    将别名指定的证书导出到文件  
            keytool -export -alias caroot -file caroot.crt  
-file      参数指定导出到文件的文件名  
-delete    删除密钥库中某条目  
            keytool -delete -alias sage -keystore sage  
-keypasswd 修改密钥库中指定条目口令  
            keytool -keypasswd -alias sage -keypass .... -new .... -storepass ... -keystore sage  
-import    将已签名数字证书导入密钥库  
            keytool -import -alias sage -keystore sagely -file sagely.crt  
           导入已签名数字证书用keytool -list -v 以后可以明显发现多了认证链长度，并且把整个CA链全部打印出来。  


