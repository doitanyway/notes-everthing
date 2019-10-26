# 使用vagrant快速安装ubuntu


## Vagrantfile

```ruby
Vagrant.configure("2") do |config|
  config.vm.provision "shell", inline: "sudo -s"
  config.vm.provision "shell", inline: "echo 'root:123456' | sudo chpasswd "
  config.vm.provision "shell", inline: "sed -i 's/^PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config "
  config.vm.provision "shell", inline: "sed -i 's/^PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config  "
  config.vm.provision "shell", inline: "service sshd restart"
  # config.ssh.username = "root"
  # config.ssh.password = "123456"

  config.vm.define "m1" do |m1|
    m1.vm.hostname = "m1.rancher.local.com"
    m1.vm.box = "ubuntu/xenial64"
    m1.vm.box_version = "20191024.0.0"

    m1.vm.network "private_network", ip: "192.168.20.11"
    m1.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 2
    end
  end

  config.vm.define "m2" do |m2|
    m2.vm.hostname = "m2.rancher.local.com"
    m2.vm.box = "ubuntu/xenial64"
    m2.vm.box_version = "20191024.0.0"
    m2.vm.network "private_network", ip: "192.168.20.12"
    m2.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 2
    end
  end

end
```


## 常用命令 

* vagrant up         ,启动
* vagrant destroy    ,关闭并销毁