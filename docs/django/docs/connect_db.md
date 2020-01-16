# 创建第一个django站点-连接数据库


* 修改配置文件``mysite/settings.py``，数据库信息根据实际情况填写  
```PY 
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'db1',
        'USER': 'root',
        'PASSWORD': '123456',
        'HOST': '127.0.0.1',
        'PORT': '3306'
    }
}
```


* 安装包，并且升级数据库

```bash 

# pip3 uninstall pymysql
# pip3 uninstall mysqlclient
pip3 install pymysql
pip3 install mysqlclient
# 如果遇到找不到mysql_config，可以使用如下第一句找到文件目录，再修改执行第二句配置环境变量
# find / -name mysql_config
# PATH="$PATH":/usr/local/mysql-5.7.26-macos10.14-x86_64/bin/

# 如下语句升级初始化数据库 
python3 manage.py migrate

```

## 创建一个models 

