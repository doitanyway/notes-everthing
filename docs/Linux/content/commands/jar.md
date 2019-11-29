# jar


* 查找

```
jar -tvf file.jar | grep filename
```

* 解压

```
jar -xvf file.jar  internal_filename
```

* 更新jar包内文件

```
jar -uvf file.jar  internal_filename
```

> internal_filename是包内的全路径.

* 添加文件到jar包

```
jar -uf file.jar add.file
```
