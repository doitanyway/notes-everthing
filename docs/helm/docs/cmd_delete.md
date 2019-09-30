# helm delete

## 作用 

该名用来在k8s中删除发布，它将会删除所有chart内申请的资源。


## 格式 

```
  helm delete [flags] RELEASE_NAME [...]
```

* 别名:  delete, del

```
Flags:
      --description string    specify a description for the release
      --dry-run               simulate a delete
  -h, --help                  help for delete
      --no-hooks              prevent hooks from running during deletion
      --purge                 remove the release from the store and make its name free for later use
      --timeout int           time in seconds to wait for any individual Kubernetes operation (like Jobs for hooks) (default 300)
      --tls                   enable TLS for request
      --tls-ca-cert string    path to TLS CA certificate file (default "$HELM_HOME/ca.pem")
      --tls-cert string       path to TLS certificate file (default "$HELM_HOME/cert.pem")
      --tls-hostname string   the server name used to verify the hostname on the returned certificates from the server
      --tls-key string        path to TLS key file (default "$HELM_HOME/key.pem")
      --tls-verify            enable TLS for request and verify remote

Global Flags:
      --debug                           enable verbose output
      --home string                     location of your Helm config. Overrides $HELM_HOME (default "/Users/nick/.helm")
      --host string                     address of Tiller. Overrides $HELM_HOST
      --kube-context string             name of the kubeconfig context to use
      --kubeconfig string               absolute path to the kubeconfig file to use
      --tiller-connection-timeout int   the duration (in seconds) Helm will wait to establish a connection to tiller (default 300)
      --tiller-namespace string         namespace of Tiller (default "kube-system")
```

