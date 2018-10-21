## volume

### volume类型

* emptyDir , 临时目录，和pod相同生命周期。如pod之间的数据共享

* hostPath, 主机目录挂到集群中

* nfs 

* glusterfs

### emptyDir

* 资源定义文件``emptyDir.yaml``

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: redis-pod
spec:
  containers:
  - image: redis
    name: redis
    volumeMounts:
    - mountPath: /cache   # 容器的目录
      name: cache-volume
  volumes:
  - name: cache-volume
    emptyDir: {}
```

* 创建``kubectl create -f emptyDir.yaml``

* 查看挂载情况

```
[root@localhost volume]# kubectl exec -it redis-pod bash 
root@redis-pod:/data# ls /cache/
root@redis-pod:/data# mount | grep cache 
/dev/mapper/centos-root on /cache type xfs (rw,relatime,attr2,inode64,noquota)
```


### hostPath


* 资源定义文件 ``hostPath.yaml``

```yaml
apiVersion: v1
kind: Pod 
metadata: 
  name: nginx-pod
spec:
  containers:
  - image: nginx
    name: nginx
    volumeMounts:    # 容器路径
    - mountPath: /test-pd
      name: test-volume
  volumes:
  - name: test-volume
    hostPath: 
      path: /tmp  #主机的路径
      type: Directory 
```

* 创建、查看镜像内的/test-pd目录

```bash
[root@localhost volume]# kubectl create -f hostPath.yaml 
pod/nginx-pod created
[root@localhost volume]# kubectl get pod 
NAME                                 READY     STATUS              RESTARTS   AGE
naginx-deployment-6c545877dc-8s9nh   1/1       Running             1          8d
naginx-deployment-6c545877dc-ckrzx   1/1       Running             1          8d
naginx-deployment-6c545877dc-wtdbb   1/1       Running             1          8d
nginx-6f858d4d45-frn56               1/1       Running             1          8d
nginx-pod                            0/1       ContainerCreating   0          7s
[root@localhost volume]# kubectl exec -it nginx-pod bash 
root@nginx-pod:/# ls /test-pd/
[root@localhost volume]# kubectl describe pod nginx-pod 
```


### nfs

* 挂载nfs之前需要先安装nfs服务器

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