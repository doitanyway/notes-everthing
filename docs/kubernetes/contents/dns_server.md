# dns服务

本文讲解kubernetes内的dns服务。

## 简介
每个集群内的service都分配得有一个dns 名称，默认情况下一个客户端POD的DNS搜索将会包含POD自己名称空间以及CLUSTER默认域名。如：

* 有一个服务foo在集群的bar名称空间内，一个pod同样在bar内可以简单的通过foo去访问，一个Pod在名称空间quux内可以通过foo.bar去访问。

## 服务的DNS

### A record

A record通常是一个域名指向一个IP地址。 

* 通常一个服务分配一个A RECORD格式如``my-svc.my-namespace.svc.cluster-domain.example``,这会被解析成service的 cluster ip。
* headless server也会有一个格式如``my-svc.my-namespace.svc.cluster-domain.example``的A记录，不像正常service 他会解析成为一组POD的IP地址。

### SRV记录

命名端口需要SRV记录，这些端口正常是service 或者是headless services的一部分，SRV格式记录如：``_my-port-name._my-port-protocol.my-svc.my-namespace.svc.cluster-domain.example``
  * 对于普通service这回被解析成为端口号和CNAME
  * 对于headless service会被解析成为多个结果，service对应的每一个backend pod各一个，包含``auto-generated-name.my-svc.my-namespace.svc.cluster-domain.example``这种POD的的端口号和CNAME

## POD的DNS

### Pod的 hostname 和 subdomain 字段

当前，创建 Pod 后，它的主机名是该 Pod 的 metadata.name 值。可以通过设置hostname 来重新主机名，此外还可以设置subdomain来指定pod的子域名。  
如：Pod 的主机名 annotation 设置为 “foo”，子域名 annotation 设置为 “bar”，在 Namespace “my-namespace” 中对应的 FQDN 为 “foo.bar.my-namespace.svc.cluster.local”。  

例： 
```YAML
apiVersion: v1
kind: Service
metadata:
  name: default-subdomain
spec:
  selector:
    name: busybox
  clusterIP: None
  ports:
  - name: foo # Actually, no port is needed.
    port: 1234
    targetPort: 1234
---
apiVersion: v1
kind: Pod
metadata:
  name: busybox1
  labels:
    name: busybox
spec:
  hostname: busybox-1
  subdomain: default-subdomain
  containers:
  - image: busybox:1.28
    command:
      - sleep
      - "3600"
    name: busybox
---
apiVersion: v1
kind: Pod
metadata:
  name: busybox2
  labels:
    name: busybox
spec:
  hostname: busybox-2
  subdomain: default-subdomain
  containers:
  - image: busybox:1.28
    command:
      - sleep
      - "3600"
    name: busybox
```


如果 Headless Service 与 Pod 在同一个 Namespace 中，它们具有相同的子域名，集群的 KubeDNS 服务器也会为该 Pod 的完整合法主机名返回 A 记录。 例如，在同一个 Namespace 中，给定一个主机名为 “busybox-1” 的 Pod，子域名设置为 “default-subdomain”，名称为 “default-subdomain” 的 Headless Service ，Pod 将看到自己的 FQDN 为 “busybox-1.default-subdomain.my-namespace.svc.cluster.local”。 DNS 会为那个名字提供一个 A 记录，指向该 Pod 的 IP。 “busybox1” 和 “busybox2” 这两个 Pod 分别具有它们自己的 A 记录。

