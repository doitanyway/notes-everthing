# helm dependency build


## 作用
Build out the charts/ directory from the requirements.lock file.

Build is used to reconstruct a chart’s dependencies to the state specified in the lock file.

If no lock file is found, ‘helm dependency build’ will mirror the behavior of the ‘helm dependency update’ command. This means it will update the on-disk dependencies to mirror the requirements.yaml file and generate a lock file.

## 格式

```
helm dependency build [flags] CHART

Options
  -h, --help             help for build
      --keyring string   Keyring containing public keys (default "~/.gnupg/pubring.gpg")
      --verify           Verify the packages against signatures
```