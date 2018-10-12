## 练习:创建react app

### 前言

本文使用create-react-app创建react项目

### 操作步骤

* 安装create-react-app
```ssh
sudo npm install -g create-react-app
```

* 创建app ``create-react-app helloworld``


* 运行app 

```
  yarn start
    Starts the development server.

  yarn build
    Bundles the app into static files for production.

  yarn test
    Starts the test runner.

  yarn eject
    Removes this tool and copies build dependencies, configuration files
    and scripts into the app directory. If you do this, you can’t go back!

We suggest that you begin by typing:

  cd helloworld
  yarn start
```

### 升级npm 


```
sudo npm cache clean -f
sudo npm install -g n
sudo n stable
```