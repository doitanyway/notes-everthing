# helm install

## 作用

安装一个chart。


## 格式

helm install [CHART] [flags]


[CHART]可以是一个chart连接，一个chart包的路径，一个未压缩的chart包的目录url。

如果需要覆盖chart中的values值，可以使用如下方法:  

```BASH
# -f传递文件覆盖
helm install -f myvalues.yaml ./redis
# --set传递单个值
helm install --set name=prod ./redis
# --set-string 设置string值
helm install --set-string long-int=1234567890 ./redis
# 使用多个文件
helm install -f myvalues.yaml -f override.yaml ./redis
# 同时修改多个值
helm install --set foo=bar --set foo=newbar ./redis
# 不执行安装，仅测试一下安装命令执行之后生成的资源
helm install ./ --debug --dry-run
```


## 例

* 安装helm包的五种方式
  * 通过chart引用: helm install stable/mariadb
  * 通过chart包: helm install ./nginx-1.2.3.tgz
  * 通过未压缩的chart包文件路径: helm install ./nginx
  * 通过绝对路径URL: helm install https://example.com/charts/nginx-1.2.3.tgz
  * 通过chart引用和chart仓库路径: helm install –repo https://example.com/charts/ nginx

* 其他例子
  * ``helm install --name mynginx ./nginx``  指定发布名称，如果不指定则动态生成
  * ``helm install --namespace nick ./nginx`` 指定名称空间，如果不指定则使用default.

