## volume emptyDir
 
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

<<<<<<< HEAD

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


## glusterfs

https://github.com/kubernetes/kubernetes/tree/8fd414537b5143ab039cb910590237cabf4af783/examples/volumes/glusterfs

### glusterfs部署

* 2个节点分别是192.168.3.92,192.168.3.92
* 2个存储卷
  * /opt/gluster/data  对应 models 
  * /opt/gluster/data1  对应 models1 


### 操作步骤

* 创建glusterfs endpoints  ``kubectl create -f glusterfs-endpoints.json``

```
{
  "kind": "Endpoints",
  "apiVersion": "v1",
  "metadata": {
    "name": "glusterfs-cluster"
  },
  "subsets": [
    {
      "addresses": [
        {
          "ip": "192.168.3.92"
        }
      ],
      "ports": [
        {
          "port": 1
        }
      ]
    },
    {
      "addresses": [
        {
          "ip": "192.168.3.93"
        }
      ],
      "ports": [
        {
          "port": 1
        }
      ]
    }
  ]
}
```
  

* 创建gluster fs service ``kubectl create -f glusterfs-service.json``

* 查看service 和endpoints

```bash
[root@localhost ~]# kubectl get svc 
NAME                TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
glusterfs-cluster   ClusterIP   10.68.183.98   <none>        1/TCP     118s
kubernetes          ClusterIP   10.68.0.1      <none>        443/TCP   5h2m
nginx-service       ClusterIP   10.68.19.152   <none>        80/TCP    46m
[root@localhost ~]# kubectl get endpoints 
NAME                ENDPOINTS                                      AGE
glusterfs-cluster   192.168.3.92:1                                 3m45s
kubernetes          192.168.3.91:6443                              5h2m
nginx-service       172.20.0.15:80,172.20.0.16:80,172.20.0.17:80   46m
```

* 创建应用

```
```
=======
>>>>>>> 4a524cdb2162e1c875a64d25523673466f944341
