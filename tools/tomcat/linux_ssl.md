# Tomcat+SSL证书

## 前言

本文介绍，如何通过cfssl生成证书，并通过openssl以及keytool 转换生成相关文件。

## 安装

* 安装cfssl
```
$ wget https://pkg.cfssl.org/R1.2/cfssl_linux-amd64
$ wget https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64
$ wget https://pkg.cfssl.org/R1.2/cfssl-certinfo_linux-amd64
$ chmod +x cfssl_linux-amd64 cfssljson_linux-amd64 cfssl-certinfo_linux-amd64
$ mv cfssl_linux-amd64 /usr/local/bin/cfssl
$ mv cfssljson_linux-amd64 /usr/local/bin/cfssljson
```

* 安装java 

```
$ yum install java 
```

* 安装openssl 

```
wget https://www.openssl.org/source/openssl-1.1.0h.tar.gz
tar -xzvf /tmp/openssl-1.1.0h.tar.gz
cd openssl-1.1.0h
./config --prefix=/usr/local/openssl   
make
make install
mv /usr/bin/openssl /usr/bin/openssl.bak
ln -sf /usr/local/openssl/bin/openssl /usr/bin/openssl
echo "/usr/local/openssl/lib" >> /etc/ld.so.conf
ldconfig -v                    
openssl version
OpenSSL 1.1.0h  27
```

##  制作证书

运行如下脚本``gen.sh``，生成证书。

```
#!/bin/bash

PASS=${1:-"123456"}

cat > ca-config.json <<EOF
{
  "signing": {
    "default": {
      "expiry": "87600h"
    },
    "profiles": {
      "kubernetes": {
         "expiry": "87600h",
         "usages": [
            "signing",
            "key encipherment",
            "server auth",
            "client auth"
        ]
      }
    }
  }
}
EOF

cat > ca-csr.json <<EOF
{
    "CN": "kubernetes",
    "key": {
        "algo": "rsa",
        "size": 2048
    },
    "names": [
        {
            "C": "CN",
            "L": "Beijing",
            "ST": "Beijing",
            "O": "k8s",
            "OU": "System"
        }
    ]
}
EOF

cfssl gencert -initca ca-csr.json | cfssljson -bare ca -

#-----------------------

cat > server-csr.json <<EOF
{
    "CN": "kubernetes",
    "hosts": [
      "127.0.0.1",
      "192.168.3.90",
      "192.168.3.91",
      "192.168.3.92",
      "10.10.10.1",
      "kubernetes",
      "kubernetes.default",
      "kubernetes.default.svc",
      "kubernetes.default.svc.cluster",
      "kubernetes.default.svc.cluster.local"
    ],
    "key": {
        "algo": "rsa",
        "size": 2048
    },
    "names": [
        {
            "C": "CN",
            "L": "BeiJing",
            "ST": "BeiJing",
            "O": "k8s",
            "OU": "System"
        }
    ]
}
EOF

cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes server-csr.json | cfssljson -bare server

#-----------------------
openssl pkcs12 -export -in server.pem -inkey server-key.pem -out server.pk12 -name serverkey -passout pass:${PASS}
keytool -importkeystore -deststorepass ${PASS} -destkeypass ${PASS} -destkeystore server.keystore -srckeystore server.pk12 -srcstoretype PKCS12 -srcstorepass ${PASS} -alias serverkey
openssl x509 -outform der -in server.pem -out server.crt
```


## tomcat 配置

* 如果使用nio链接
```
 <Connector
           protocol="org.apache.coyote.http11.Http11NioProtocol"
           port="8443" maxThreads="200"
           scheme="https" secure="true" SSLEnabled="true"
           keystoreFile="/root/ssl/server.keystore" keystorePass="123456"
           clientAuth="false" sslProtocol="TLS"/>
```

* 如果使用apr链接

```
<Connector
           protocol="org.apache.coyote.http11.Http11AprProtocol"
           port="8443" maxThreads="200"
           scheme="https" secure="true" SSLEnabled="true"
           SSLCertificateFile="/root/ssl/server.crt"
           SSLCertificateKeyFile="/root/ssl/server.pem"
           SSLVerifyClient="optional" SSLProtocol="TLSv1+TLSv1.1+TLSv1.2"/>
```
>  需要pem文件转换crt格式。