## service-3.ExternalName


当集群内部需要访问集群外部的一个服务的时候，我们会用到ExternalName和External IPs

官方资料：
https://kubernetes.io/docs/concepts/services-networking/service/#externalname


* ExternalName

* 例子``kubectl apply -f ExternalName.yaml``

```yaml
kind: Service
apiVersion: v1
metadata:
  name: my-service
  namespace: default
spec:
  type: ExternalName
  externalName: www.baidu.com
```


* 集群外部ip服务，引入集群内部,“80.11.12.10:80”” (externalIP:port)


```yaml
kind: Service
apiVersion: v1
metadata:
  name: my-service
spec:
  selector:
    app: MyApp
  ports:
  - name: http
    protocol: TCP
    port: 80
    targetPort: 9376
  externalIPs:
  - 80.11.12.10
```