# 创建第一个django站点

## 

```bash 
# 创建project
django-admin startproject mysite

# 启动项目
cd mysite
python3 manage.py migrate
python3 manage.py runserver

# 访问http://127.0.0.1:8000/检查第一个应用是否正常启动。

# 修改端口启动服务
python3 manage.py runserver 8080

# 绑定网卡启动服务，如下0是0.0.0.0的简称
python3 manage.py runserver 0:8000

````