# 使用vagrant快速安装centos



## Vagrantfile

```
Vagrant.configure("2") do |config|
  config.vm.provision "shell", inline: "echo Hello"
  config.vm.provision "shell", inline: "su"
  config.vm.provision "shell", inline: "sudo echo '123456' | passwd --stdin root "

  config.vm.define "m1" do |m1|
    m1.vm.box = "centos/7"
    m1.vm.box_version = "1811.02"
    m1.vm.network "private_network", ip: "192.168.80.11"
    m1.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 2
    end
  end
end
```


## 常用命令 

* vagrant up 
* 