# helm dependency update

## 作用

Update the on-disk dependencies to mirror the requirements.yaml file.

This command verifies that the required charts, as expressed in ‘requirements.yaml’, are present in ‘charts/’ and are at an acceptable version. It will pull down the latest charts that satisfy the dependencies, and clean up old dependencies.

On successful update, this will generate a lock file that can be used to rebuild the requirements to an exact version.

Dependencies are not required to be represented in ‘requirements.yaml’. For that reason, an update command will not remove charts unless they are (a) present in the requirements.yaml file, but (b) at the wrong version.


## 格式

```
helm dependency update [flags] CHART
Options
  -h, --help             help for update
      --keyring string   Keyring containing public keys (default "~/.gnupg/pubring.gpg")
      --skip-refresh     Do not refresh the local repository cache
      --verify           Verify the packages against signatures
``` 