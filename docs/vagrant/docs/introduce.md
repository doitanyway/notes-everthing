# vagrant入门

# vagrant是什么  
vagrant 是用来建立和管理虚拟机运行环境的一个工具，其优点如下：

* 容易使用
* 自动化
* 搭建方便

对于开发人员来说，能够快速搭建出一套类似于生产环境的执行环境。


# 安装

* 如果是windows [请关闭Hyper-v](https://jingyan.baidu.com/article/f96699bbf2b889894f3c1b6f.html)（这里是个耿，docker又需要打开Hyper-v）
* [安装vagrant](https://www.vagrantup.com/docs/installation/)
* [安装virtualbox](https://www.virtualbox.org/) 

# 快速使用

```
mkdir os 
cd os 
# vagrant init hashicorp/precise64
## 初始化CNETOS7虚拟机  
vagrant init centos/7
## 启动虚拟机
vagrant up
## ssh 登录虚拟机
vagrant ssh 
## 重启虚拟机
vagrant reload
```
> 执行``vagrant init ``之后，在执行目录下会生成一个Vagrantfile文件，该文件决定了虚拟机的具体配置，后续如无特殊说明，都是指该文件的配置。

# 共享文件

主机的Vagrantfile文件所在目录和虚拟机的 /vagrant/文件目录共享一个文件夹，如果需要在主机和虚拟机之间传送文件，可以使用该文件夹。

# 网络

## 端口转发

端口转发可以讲主机某个端口的数据，转发到虚拟机的某个端口上，使用配置Vagrantfile文件如下：

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/precise64"
  config.vm.provision :shell, path: "bootstrap.sh"
  config.vm.network :forwarded_port, guest: 80, host: 4567
end
```
## 私有网络

私有网络可以使我们创建的虚拟机，其可被主机访问当时不能被外网访问。

### dhcp 

dhcp 私有网络会将为虚拟机自动分配一个预留的ip地址。

```
Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/precise64"
  config.vm.network "private_network", type: "dhcp"
end
```

### 静态IP

静态ip将会为虚拟机分配一个静态的ip地址，使用方法如下：

```
Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/precise64"
  config.vm.network "private_network", ip: "192.168.50.4"
end
```

我们也可以定义静态ip为ipv6.(DHCP 暂时不支持ipv6).用法如下：

```
Vagrant.configure("2") do |config|
  config.vm.network "private_network", ip: "fde4:8dba:82e1::c4"
end
```

我们也可以设置掩码长度（默认为64）；

```
Vagrant.configure("2") do |config|
  config.vm.network "private_network",
    ip: "fde4:8dba:82e1::c4",
    netmask: "96"
end
```


# 多虚拟机管理

多个虚拟机管理，只需要按如下代码配置Vagrantfile即可。

```
Vagrant.configure("2") do |config|
  config.vm.provision "shell", inline: "echo Hello"

  config.vm.define "m1" do |m1|
    m1.vm.box = "centos/7"
    m1.vm.box_version = "1811.02"
    m1.vm.network "private_network", ip: "192.168.50.4"
    m1.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 2
    end
  end

  config.vm.define "m2" do |m2|
    m2.vm.box = "centos/7"
    m2.vm.box_version = "1811.02"
    m2.vm.network "private_network", ip: "192.168.50.5"
    m2.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 2
    end
  end
end
```

> 此时需要注意控制节点的时候需要加上节点名字，如``vagrant ssh m1``


# 制作自己的box 

* 登录[官网](https://app.vagrantup.com/)，给自己申请一个账户
* 在该网站上创建一个vagrant box
* 本机使用``vagrant login``登录vagrant 官网；
* 打开virtual box查看虚拟机全名，这里是``centos_m1_1547349402829_39867``
* 打包虚拟机为box  ``vagrant package --base  centos_m1_1547349402829_39867 --output busybox.box``
* 上传打包好的box到官网，完成box发布