# PersistentVolumeClaim

## 前言

PersistentVolume(PV，持久卷):对存储抽象实现，使得存储作为集群中的资源。  
PersistentVolumeClaim(PVC，持久卷申请):PVC消费PV的资源。  
Pod申请PVC作为卷来使用，集群通过PVC查找绑定的PV，并Mount给Pod。  

PV 和PVC作为集群资源进行管理和分配。



##  创建五个nfs存储卷


* 在/data/volumes目录下，创建文件夹``mkdir v{1,2,3,4,5}``     
```
v1  v2  v3  v4  v5
```

* 编辑nfs卷配置文件``/etc/exports``
```
/data/volumes/v1  192.168.60.0/24(rw,no_root_squash)
/data/volumes/v2  192.168.60.0/24(rw,no_root_squash)
```

* 配置生效文件

```bash
[root@localhost volumes]# vim /etc/exports
[root@localhost volumes]# exportfs -arv 
exporting 192.168.60.0/24:/data/volumes/v2
exporting 192.168.60.0/24:/data/volumes/v1
[root@localhost volumes]# showmount -e 
Export list for localhost.localdomain:
/data/volumes/v2 192.168.60.0/24
/data/volumes/v1 192.168.60.0/24
```


* 创建pv ``kubectl apply -f pv-demo.yaml``

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv001
  labels:
    name: pv001
spec:
  nfs:
    path: /data/volumes/v1
    # m3 can be ip address too.
    server: m3
  accessModes: ["ReadWriteMany","ReadWriteOnce"]
  capacity:
    storage: 1Gi
---

apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv002
  labels:
    name: pv002
spec:
  nfs:
    path: /data/volumes/v2
    # m3 can be ip address too.
    server: m3
  accessModes: ["ReadWriteMany","ReadWriteOnce"]
  capacity:
    storage: 2Gi
```

* 查看pv状态  ``kubectl get pv``

```bash
[root@localhost pvc]# kubectl get pv 
NAME      CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM     STORAGECLASS   REASON    AGE
pv001     1Gi        RWO,RWX        Retain           Available                                      6s
pv002     2Gi        RWO,RWX        Retain           Available                                      6s
```

* pod里面使用pvc挂载 ``kubectl apply -f pod-vol-pvc.yaml ``  

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mypvc
  namespace: default
spec:
  accessModes: ["ReadWriteMany"]
  resources:
    requests:
      storage: 3Gi
---
apiVersion: v1
kind: Pod
metadata:
  name: pod-vol-pvc
  namespace: default
spec:
  containers:
  - name: myapp
    image: ikubernetes/myapp:v1
    volumeMounts:
    - name: html
      mountPath: /usr/share/nginx/html/
  volumes:
  - name: html
    persistentVolumeClaim:
      # the pvc that will be use
      claimName: mypvc
```


* 验证查看状态

```
[root@localhost pvc]# kubectl get pv 
NAME      CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM           STORAGECLASS   REASON    AGE
pv001     1Gi        RWO,RWX        Retain           Available                                            16m
pv002     2Gi        RWO,RWX        Retain           Available                                            16m
pv003     3Gi        RWO,RWX        Retain           Bound       default/mypvc                            16m
pv004     4Gi        RWO,RWX        Retain           Available                                            16m
pv005     5Gi        RWO,RWX        Retain           Available                                            16m
[root@localhost pvc]# kubectl get pvc 
NAME      STATUS    VOLUME    CAPACITY   ACCESS MODES   STORAGECLASS   AGE
mypvc     Bound     pv003     3Gi        RWO,RWX                       3m
```