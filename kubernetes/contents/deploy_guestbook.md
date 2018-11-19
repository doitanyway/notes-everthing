# 部署guestbook

* [英文原文](https://kubernetes.io/docs/tutorials/stateless-application/guestbook/)

* [科学获取镜像](https://github.com/doitanyway/notes-everything/blob/master/docker/content/save_load.md),由于在国内，不能访问google镜像，本
 

本教程教会我们如何使用k8s部署一个简单的应用,本应用有如下组件:

* 一个redis master实例[Redis](https://redis.io/)，用来存储guestbook 实体
* 多个 [replicated Redis](https://redis.io/topics/replication) 实例用来读
* 多个web前端实例；

本教程按如下顺序讲解：
 
* 启动一个Redis master.
* 启动一个 Redis slaves.
* 启动guestbook 前端.
* 暴露前端服务.
* 清理.


## 启动 Redis Master

 guestbook 应用使用 Redis存储数据 . 他写数据到reids master,通过redis slave来读取数据；
 

### 创建 Redis Master Deployment

1. 创建  Redis Master 应用 `redis-master-deployment.yaml`:

```shell
kubectl apply -f redis-master-deployment.yaml
```
      
```yaml
apiVersion: apps/v1 # for versions before 1.9.0 use apps/v1beta2
kind: Deployment
metadata:
  name: redis-master
  labels:
    app: redis
spec:
  selector:
    matchLabels:
      app: redis
      role: master
      tier: backend
  replicas: 1
  template:
    metadata:
      labels:
        app: redis
        role: master
        tier: backend
    spec:
      containers:
      - name: master
        image: redis       #   k8s.gcr.io/redis:e2e  # or just image: redis
        resources:
          requests:
            cpu: 100m
            memory: 100Mi
        ports:
        - containerPort: 6379
```

1. 查询pod的运行情况，验证redis master是否正常运行:

```shell
kubectl get pods
```


1. 执行如下的任务，看redis master的日志:

```shell
kubectl logs -f POD-NAME
```

> POD-NAME 替换成为实际的pod name


### 创建redis master 的服务

 guestbook 应用需要与master通讯书写数据。


1. 创建 Redis Master 服务: 

```shell
kubectl apply -f redis-master-service.yaml
```

```yaml
apiVersion: v1
kind: Service
metadata:
  name: redis-master
  labels:
    app: redis
    role: master
    tier: backend
spec:
  ports:
  - port: 6379
    targetPort: 6379
  selector:
    app: redis
    role: master
    tier: backend
```

1. 验证服务是否正常运行：

      ```shell
      kubectl get service
      ```

      应答如下:

      ```shell
      NAME           TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)    AGE
      kubernetes     ClusterIP   10.0.0.1     <none>        443/TCP    1m
      redis-master   ClusterIP   10.0.0.151   <none>        6379/TCP   8s
      ```

{{< note >}}
This manifest file creates a Service named `redis-master` with a set of labels that match the labels previously defined, so the Service routes network traffic to the Redis master Pod.   
{{< /note >}}


## Start up the Redis Slaves

Although the Redis master is a single pod, you can make it highly available to meet traffic demands by adding replica Redis slaves.

### Creating the Redis Slave Deployment

Deployments scale based off of the configurations set in the manifest file. In this case, the Deployment object specifies two replicas. 

If there are not any replicas running, this Deployment would start the two replicas on your container cluster. Conversely, if there are more than two replicas are running, it would scale down until two replicas are running. 

{{< codenew file="application/guestbook/redis-slave-deployment.yaml" >}}

1. Apply the Redis Slave Deployment from the `redis-slave-deployment.yaml` file:

      ```shell
      kubectl apply -f https://k8s.io/examples/application/guestbook/redis-slave-deployment.yaml
      ```

1. Query the list of Pods to verify that the Redis Slave Pods are running:

      ```shell
      kubectl get pods
      ```

      The response should be similar to this:

      ```shell
      NAME                            READY     STATUS              RESTARTS   AGE
      redis-master-1068406935-3lswp   1/1       Running             0          1m
      redis-slave-2005841000-fpvqc    0/1       ContainerCreating   0          6s
      redis-slave-2005841000-phfv9    0/1       ContainerCreating   0          6s
      ```

### Creating the Redis Slave Service

The guestbook application needs to communicate to Redis slaves to read data. To make the Redis slaves discoverable, you need to set up a Service. A Service provides transparent load balancing to a set of Pods.

{{< codenew file="application/guestbook/redis-slave-service.yaml" >}}

1. Apply the Redis Slave Service from the following `redis-slave-service.yaml` file:

      ```shell
      kubectl apply -f https://k8s.io/examples/application/guestbook/redis-slave-service.yaml
      ```

1. Query the list of Services to verify that the Redis slave service is running:

      ```shell
      kubectl get services
      ```

      The response should be similar to this:

      ```
      NAME           TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)    AGE
      kubernetes     ClusterIP   10.0.0.1     <none>        443/TCP    2m
      redis-master   ClusterIP   10.0.0.151   <none>        6379/TCP   1m
      redis-slave    ClusterIP   10.0.0.223   <none>        6379/TCP   6s
      ```

## Set up and Expose the Guestbook Frontend

The guestbook application has a web frontend serving the HTTP requests written in PHP. It is configured to connect to the `redis-master` Service for write requests and the `redis-slave` service for Read requests.

### Creating the Guestbook Frontend Deployment

{{< codenew file="application/guestbook/frontend-deployment.yaml" >}}

1. Apply the frontend Deployment from the `frontend-deployment.yaml` file:

      ```shell
      kubectl apply -f https://k8s.io/examples/application/guestbook/frontend-deployment.yaml
      ```

1. Query the list of Pods to verify that the three frontend replicas are running:

      ```shell
      kubectl get pods -l app=guestbook -l tier=frontend
      ```

      The response should be similar to this:

      ```
      NAME                        READY     STATUS    RESTARTS   AGE
      frontend-3823415956-dsvc5   1/1       Running   0          54s
      frontend-3823415956-k22zn   1/1       Running   0          54s
      frontend-3823415956-w9gbt   1/1       Running   0          54s
      ```

### Creating the Frontend Service

The `redis-slave` and `redis-master` Services you applied are only accessible within the container cluster because the default type for a Service is [ClusterIP](/docs/concepts/services-networking/service/#publishing-services---service-types). `ClusterIP` provides a single IP address for the set of Pods the Service is pointing to. This IP address is accessible only within the cluster.

If you want guests to be able to access your guestbook, you must configure the frontend Service to be externally visible, so a client can request the Service from outside the container cluster. Minikube can only expose Services through `NodePort`.  

{{< note >}}
Some cloud providers, like Google Compute Engine or Google Kubernetes Engine, support external load balancers. If your cloud provider supports load balancers and you want to use it, simply delete or comment out `type: NodePort`, and uncomment `type: LoadBalancer`. 
{{< /note >}}

{{< codenew file="application/guestbook/frontend-service.yaml" >}}

1. Apply the frontend Service from the `frontend-service.yaml` file:

      ```shell
      kubectl apply -f https://k8s.io/examples/application/guestbook/frontend-service.yaml
      ```

1. Query the list of Services to verify that the frontend Service is running:

      ```shell
      kubectl get services 
      ```

      The response should be similar to this:

      ```
      NAME           TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)        AGE
      frontend       ClusterIP   10.0.0.112   <none>       80:31323/TCP   6s
      kubernetes     ClusterIP   10.0.0.1     <none>        443/TCP        4m
      redis-master   ClusterIP   10.0.0.151   <none>        6379/TCP       2m
      redis-slave    ClusterIP   10.0.0.223   <none>        6379/TCP       1m
      ```

### Viewing the Frontend Service via `NodePort`

If you deployed this application to Minikube or a local cluster, you need to find the IP address to view your Guestbook.

1. Run the following command to get the IP address for the frontend Service.

      ```shell
      minikube service frontend --url
      ```

      The response should be similar to this:

      ```
      http://192.168.99.100:31323
      ```

1. Copy the IP address, and load the page in your browser to view your guestbook.

### Viewing the Frontend Service via `LoadBalancer`

If you deployed the `frontend-service.yaml` manifest with type: `LoadBalancer` you need to find the IP address to view your Guestbook.

1. Run the following command to get the IP address for the frontend Service.

      ```shell
      kubectl get service frontend
      ```

      The response should be similar to this:

      ```
      NAME       TYPE        CLUSTER-IP      EXTERNAL-IP        PORT(S)        AGE
      frontend   ClusterIP   10.51.242.136   109.197.92.229     80:32372/TCP   1m
      ```

1. Copy the external IP address, and load the page in your browser to view your guestbook.

## Scale the Web Frontend 

Scaling up or down is easy because your servers are defined as a Service that uses a Deployment controller.

1. Run the following command to scale up the number of frontend Pods:

      ```shell
      kubectl scale deployment frontend --replicas=5
      ```

1. Query the list of Pods to verify the number of frontend Pods running:

      ```shell
      kubectl get pods
      ```

      The response should look similar to this: 

      ```
      NAME                            READY     STATUS    RESTARTS   AGE
      frontend-3823415956-70qj5       1/1       Running   0          5s
      frontend-3823415956-dsvc5       1/1       Running   0          54m
      frontend-3823415956-k22zn       1/1       Running   0          54m
      frontend-3823415956-w9gbt       1/1       Running   0          54m
      frontend-3823415956-x2pld       1/1       Running   0          5s
      redis-master-1068406935-3lswp   1/1       Running   0          56m
      redis-slave-2005841000-fpvqc    1/1       Running   0          55m
      redis-slave-2005841000-phfv9    1/1       Running   0          55m
      ```

1. Run the following command to scale down the number of frontend Pods:

      ```shell
      kubectl scale deployment frontend --replicas=2
      ```

1. Query the list of Pods to verify the number of frontend Pods running:

      ```shell
      kubectl get pods
      ```

      The response should look similar to this:

      ```
      NAME                            READY     STATUS    RESTARTS   AGE
      frontend-3823415956-k22zn       1/1       Running   0          1h
      frontend-3823415956-w9gbt       1/1       Running   0          1h
      redis-master-1068406935-3lswp   1/1       Running   0          1h
      redis-slave-2005841000-fpvqc    1/1       Running   0          1h
      redis-slave-2005841000-phfv9    1/1       Running   0          1h
      ```
        
{{% /capture %}}

{{% capture cleanup %}}
Deleting the Deployments and Services also deletes any running Pods. Use labels to delete multiple resources with one command.

1. Run the following commands to delete all Pods, Deployments, and Services.

      ```shell
      kubectl delete deployment -l app=redis
      kubectl delete service -l app=redis
      kubectl delete deployment -l app=guestbook
      kubectl delete service -l app=guestbook
      ```

      The responses should be:

      ```
      deployment.apps "redis-master" deleted
      deployment.apps "redis-slave" deleted
      service "redis-master" deleted
      service "redis-slave" deleted
      deployment.apps "frontend" deleted    
      service "frontend" deleted
      ```
       
1. Query the list of Pods to verify that no Pods are running:

      ```shell
      kubectl get pods
      ```

      The response should be this: 

      ```
      No resources found.
      ```

{{% /capture %}}

{{% capture whatsnext %}}
* Complete the [Kubernetes Basics](/docs/tutorials/kubernetes-basics/) Interactive Tutorials
* Use Kubernetes to create a blog using [Persistent Volumes for MySQL and Wordpress](/docs/tutorials/stateful-application/mysql-wordpress-persistent-volume/#visit-your-new-wordpress-blog) 
* Read more about [connecting applications](/docs/concepts/services-networking/connect-applications-service/)
* Read more about [Managing Resources](/docs/concepts/cluster-administration/manage-deployment/#using-labels-effectively)
{{% /capture %}}

