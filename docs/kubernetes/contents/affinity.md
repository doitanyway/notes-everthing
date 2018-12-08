## affinity/亲和性

* affinity，亲和性，利用亲和性指定pod部署的node的ip

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: cce21days-qiujiahong
  labels:
    app: nginx 
spec: 
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution: 
        nodeSelectorTerms:
          - matchExpressions: 
            - key: kubernetes.io/hostname
              operator: In
              values:
              - 192.168.0.197 #有EIP的node节点的私网IP地址
  containers:
  - image: nginx
    imagePullPolicy: IfNotPresent 
    name: container-0
    resources: {}
  dnsPolicy: ClusterFirst 
  imagePullSecrets:
  - name: default-secret 
  restartPolicy: Always 
  schedulerName: default-scheduler 
  securityContext: {}
```

* podAntiAffinity,反亲和性，利用反亲和性使deployment下的pod部署在不同的node上。

```yaml
kind: Deployment
apiVersion: apps/v1
metadata:
  name: cce21days-app1-qiujiahong
  namespace: default
spec:
  replicas: 2 
  selector: 
    matchLabels:
      app: cce21days-app1-qiujiahong
  template: 
    metadata: 
      labels: 
        app: cce21days-app1-qiujiahong
    spec: 
      containers: 
        - name: container-0
          image: nginx
          imagePullPolicy: IfNotPresent
      restartPolicy: Always
      dnsPolicy: ClusterFirst
      imagePullSecrets:
        - name: default-secret
      affinity:
        podAntiAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            - labelSelector:
                matchExpressions:
                  - key: app
                    operator: In
                    values: 
                      - cce21days-app1-qiujiahong
              topologyKey: kubernetes.io/hostname
      schedulerName: default-scheduler	 
```


* affinity,利用亲和性使pod和某个含指定标签的pod部署在同一个node上

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels: 
    appgroup: ''
  name: cce21days-app2-qiujiahong
  namespace: default
spec:  
  replicas: 2
  selector:
    matchLabels:
      app: cce21days-app2-qiujiahong
  template:
    metadata:
      labels:
        app: cce21days-app2-qiujiahong
    spec: 
      containers:
        - image: 'swr.cn-north-1.myhuaweicloud.com/qiujiahong/tank:1.0.1'
          name: container-0
      imagePullSecrets:
        - name: default-sercret
      # 此处亲和性设置是为了将pod调度到有EIP的节点，便于下载外网镜像
      affinity: 
        podAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            - labelSelector:
                matchExpressions:
                  - key: app
                    operator: In 
                    values: 
                      - cce21days-app1-qiujiahong
              topologyKey: kubernetes.io/hostname
```