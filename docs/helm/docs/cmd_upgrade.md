# helm upgrade

## 作用

更新一个已经发布了的版本

更新一个发布到指定的版本，也可以用来更新value。


## 格式

```
Usage:
  helm upgrade [RELEASE] [CHART] [flags]

Flags:
      --atomic                   if set, upgrade process rolls back changes made in case of failed upgrade, also sets --wait flag
      --ca-file string           verify certificates of HTTPS-enabled servers using this CA bundle
      --cert-file string         identify HTTPS client using this SSL certificate file
      --cleanup-on-fail          allow deletion of new resources created in this upgrade when upgrade failed
      --description string       specify the description to use for the upgrade, rather than the default
      --devel                    use development versions, too. Equivalent to version '>0.0.0-0'. If --version is set, this is ignored.
      --dry-run                  simulate an upgrade
      --force                    force resource update through delete/recreate if needed
  -h, --help                     help for upgrade
  -i, --install                  if a release by this name doesn't already exist, run an install
      --key-file string          identify HTTPS client using this SSL key file
      --keyring string           path to the keyring that contains public signing keys (default "/Users/nick/.gnupg/pubring.gpg")
      --namespace string         namespace to install the release into (only used if --install is set). Defaults to the current kube config namespace
      --no-hooks                 disable pre/post upgrade hooks
      --password string          chart repository password where to locate the requested chart
      --recreate-pods            performs pods restart for the resource if applicable
      --render-subchart-notes    render subchart notes along with parent
      --repo string              chart repository url where to locate the requested chart
      --reset-values             when upgrading, reset the values to the ones built into the chart
      --reuse-values             when upgrading, reuse the last release's values and merge in any overrides from the command line via --set and -f. If '--reset-values' is specified, this is ignored.
      --set stringArray          set values on the command line (can specify multiple or separate values with commas: key1=val1,key2=val2)
      --set-file stringArray     set values from respective files specified via the command line (can specify multiple or separate values with commas: key1=path1,key2=path2)
      --set-string stringArray   set STRING values on the command line (can specify multiple or separate values with commas: key1=val1,key2=val2)
      --timeout int              time in seconds to wait for any individual Kubernetes operation (like Jobs for hooks) (default 300)
      --tls                      enable TLS for request
      --tls-ca-cert string       path to TLS CA certificate file (default "$HELM_HOME/ca.pem")
      --tls-cert string          path to TLS certificate file (default "$HELM_HOME/cert.pem")
      --tls-hostname string      the server name used to verify the hostname on the returned certificates from the server
      --tls-key string           path to TLS key file (default "$HELM_HOME/key.pem")
      --tls-verify               enable TLS for request and verify remote
      --username string          chart repository username where to locate the requested chart
  -f, --values valueFiles        specify values in a YAML file or a URL(can specify multiple) (default [])
      --verify                   verify the provenance of the chart before upgrading
      --version string           specify the exact chart version to use. If this is not specified, the latest version is used
      --wait                     if set, will wait until all Pods, PVCs, Services, and minimum number of Pods of a Deployment are in a ready state before marking the release as successful. It will wait for as long as --timeout

Global Flags:
      --debug                           enable verbose output
      --home string                     location of your Helm config. Overrides $HELM_HOME (default "/Users/nick/.helm")
      --host string                     address of Tiller. Overrides $HELM_HOST
      --kube-context string             name of the kubeconfig context to use
      --kubeconfig string               absolute path to the kubeconfig file to use
      --tiller-connection-timeout int   the duration (in seconds) Helm will wait to establish a connection to tiller (default 300)
      --tiller-namespace string         namespace of Tiller (default "kube-system")
```

## 例


```bash
helm upgrade -f myvalues.yaml -f override.yaml redis ./redis
# 指定name space 
helm upgrade -f myvalues.yaml -f override.yaml --namespace -nick-dev redis ./redis
```