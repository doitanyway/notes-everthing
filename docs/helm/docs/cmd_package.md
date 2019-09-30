# helm package

##  作用

该命令把一个chart包打包成为一个带版本的压缩chart文件包。

带版本的chart压缩包，可以被Helm package 仓库使用

## 格式
```
  helm package [flags] [CHART_PATH] [...]
```

```
Flags:
      --app-version string   set the appVersion on the chart to this version
  -u, --dependency-update    update dependencies from "requirements.yaml" to dir "charts/" before packaging
  -d, --destination string   location to write the chart. (default ".")
  -h, --help                 help for package
      --key string           name of the key to use when signing. Used if --sign is true
      --keyring string       location of a public keyring (default "/Users/nick/.gnupg/pubring.gpg")
      --save                 save packaged chart to local chart repository (default true)
      --sign                 use a PGP private key to sign this package
      --version string       set the version on the chart to this semver version

Global Flags:
      --debug                           enable verbose output
      --home string                     location of your Helm config. Overrides $HELM_HOME (default "/Users/nick/.helm")
      --host string                     address of Tiller. Overrides $HELM_HOST
      --kube-context string             name of the kubeconfig context to use
      --kubeconfig string               absolute path to the kubeconfig file to use
      --tiller-connection-timeout int   the duration (in seconds) Helm will wait to establish a connection to tiller (default 300)
      --tiller-namespace string         namespace of Tiller (default "kube-system")

```