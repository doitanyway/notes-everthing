## volume 3.nfs

* 挂载nfs之前需要先安装nfs服务器,nfs服务器的安装，请参考[该文章](https://www.jianshu.com/p/c4baebb724b6)

* 运行创建如下nginx deployment ``kubectl apply -f nginx-deployment.yaml ``

```yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata: 
  name: nginx-deployment
spec:
  replicas: 3
  template: 
    metadata:
      labels:
        app: nginx
    spec: 
      containers:
      - name: nginx
        image: nginx 
        volumeMounts:
        - name: wwwroot
          mountPath: /usr/share/nginx/html
        ports:
        - containerPort: 80
      volumes:
      - name: wwwroot
        nfs: 
          server: 192.168.3.93
          path: /var/nfsshare
```

* 运行创建一个service供测试``kubectl apply -f nginx-service.yaml``

```yaml
apiVersion: v1
kind: Service
metadata: 
  name: nginx-service
  labels:
    app: nginx
spec: 
  ports:
  - port: 80
    targetPort: 80
  selector:
    app: nginx
#  type: NodePort
```

* 测试nginx网页链接

```bash
[root@localhost ~]# kubectl get svc 
NAME            TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
kubernetes      ClusterIP   10.68.0.1      <none>        443/TCP   4h20m
nginx-service   ClusterIP   10.68.19.152   <none>        80/TCP    4m2s
[root@localhost ~]# curl 10.68.19.152

首页

```

* 可以登陆nfs服务器，修改文件，重新curl 访问该服务；