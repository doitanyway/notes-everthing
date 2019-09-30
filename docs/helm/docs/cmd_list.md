# helm list

## 作用


* 列举发布的chart 。
* 默认该命令是字母排序，可以加-d flag修改排序为按时间排序。
* 可以使用缩写helm ls 

## 格式

```
  helm list [flags] [FILTER]
```

```
Aliases:
  list, ls

Flags:
  -a, --all                   show all releases, not just the ones marked DEPLOYED
  -c, --chart-name            sort by chart name
      --col-width uint        specifies the max column width of output (default 60)
  -d, --date                  sort by release date
      --deleted               show deleted releases
      --deleting              show releases that are currently being deleted
      --deployed              show deployed releases. If no other is specified, this will be automatically enabled
      --failed                show failed releases
  -h, --help                  help for list
  -m, --max int               maximum number of releases to fetch (default 256)
      --namespace string      show releases within a specific namespace
  -o, --offset string         next release name in the list, used to offset from start value
      --output string         output the specified format (json or yaml)
      --pending               show pending releases
  -r, --reverse               reverse the sort order
  -q, --short                 output short (quiet) listing format
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