# scp

## 常见用法

* 上传本地文件到服务器
```
scp /path/filename username@servername:/path/
```
例如scp /var/www/test.php root@192.168.0.101:/var/www/ 把本机/var/www/目录下的test.php文件上传到192.168.0.101这台服务器上的/var/www/目录中

 

* 从服务器上下载文件

下载文件我们经常使用wget，但是如果没有http服务，如何从服务器上下载文件呢？
```
scp username@servername:/path/filename /var/www/local_dir（本地目录）
```
例如scp root@192.168.0.101:/var/www/test.txt 把192.168.0.101上的/var/www/test.txt 的文件下载到/var/www/local_dir（本地目录）

 
* 从服务器下载整个目录
```
scp -r username@servername:/var/www/remote_dir/（远程目录） /var/www/local_dir（本地目录）
```
例如:scp -r root@192.168.0.101:/var/www/test /var/www/

 
* 上传目录到服务器
```
scp -r local_dir username@servername:remote_dir
```
例如：scp -r test root@192.168.0.101:/var/www/ 把当前目录下的test目录上传到服务器的/var/www/ 目录

* 指定端口
```
scp -P 16022 file user@host:/dir
```

## 错误

* 如果提示找不到scp命令，则可以在服务器端执行命令安装
```
yum install openssh-server
yum install openssh-clients 
```