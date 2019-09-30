## helm create 

该命令创建一个chart目录，并创建相关的文件。

如 'helm create foo'将会创建如下结构的文件：
```YAML
	foo/
	  |
	  |- .helmignore        # Contains patterns to ignore when packaging Helm charts.
	  |
	  |- Chart.yaml         # Information about your chart
	  |
	  |- values.yaml        # The default values for your templates
	  |
	  |- charts/            # Charts that this chart depends on
	  |
	  |- templates/         # The template files
	  |
	  |- templates/tests/   # The test files
```

'helm create'命令紧接着一个名字作为参数。如果文件不存在，helm将会创建。如果文件已经存在，那么冲突的文件将会被删除，其他文件保留。

使用方法:
```BASH
  helm create NAME [flags]
```

* Flags:
  -h, --help             help for create
  -p, --starter string   the named Helm starter scaffold

* 全局 Flags:
      --debug                           enable verbose output
      --home string                     location of your Helm config. Overrides $HELM_HOME (default "/Users/nick/.helm")
      --host string                     address of Tiller. Overrides $HELM_HOST
      --kube-context string             name of the kubeconfig context to use
      --kubeconfig string               absolute path to the kubeconfig file to use
      --tiller-connection-timeout int   the duration (in seconds) Helm will wait to establish a connection to tiller (default 300)
      --tiller-namespace string         namespace of Tiller (default "kube-system")
