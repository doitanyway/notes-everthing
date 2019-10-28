# service-6.配置https

## 生成证书和secret 


```BASH
# 1】创建私钥
openssl genrsa -out nginx.key 2048
# 2】创建证书（本次整为一行创建）PS：CN必须为访问的域名相同
openssl req -new -x509 -key nginx.key -out nginx.crt -subj /C=CN/ST=SZ/L=SZ/O=DevOps/CN=nickqiu.com
# 3】创建k8s格式使用的secret,nick-ingress-secret
kubectl create secret tls nick-ingress-secret --cert=nginx.crt --key=nginx.key
```

### 部署应用  

* ``kubectl apply -f ingress.yaml``,部署deployment,Service,Ingress,ingress.yaml文件如下：

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: example-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  tls:
  - hosts:
    - nickqiu.com
    secretName: nick-ingress-secret
  rules:
  - host: nickqiu.com
    http:
      paths:
      - path: /
        backend:
          serviceName: my-service
          servicePort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  selector:
    app: MyApp
  type: NodePort
  ports:
  - name: http
    protocol: TCP
    port: 80
    targetPort: 80
---
apiVersion: apps/v1beta2
kind: Deployment
metadata:
  name: naginx-deployment
  namespace: default
  labels:
    web: MyApp
spec:
  replicas: 1
  selector:
    matchLabels:
      app: MyApp
  template:
    metadata:
      labels:
        app: MyApp
    spec:
      containers:
      - name: nginx
        image: nginx:1.10
        ports:
        - containerPort: 80
```


