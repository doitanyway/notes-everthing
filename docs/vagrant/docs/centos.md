# 常用box-centos


* 启动脚本``Vagrantfile``

```ruby 
Vagrant.configure("2") do |config|
    config.vm.provision "shell", inline: "echo Hello"
    config.vm.provision "shell", inline: "su"
    config.vm.provision "shell", inline: "sudo echo '123456' | passwd --stdin root "

    config.vm.provision "shell", inline: "sed -i 's/^#PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config"
    config.vm.provision "shell", inline: "sed -i 's/^#UsePAM.*/UsePAM yes/g' /etc/ssh/sshd_config"
    config.vm.provision "shell", inline: "sed -i 's/^PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config "
    config.vm.provision "shell", inline: "systemctl restart sshd.service"
  
    config.vm.define "node1" do |node1|
        node1.vm.box = "centos/7"
        node1.vm.box_version = "1811.02"
        node1.vm.network "private_network", ip: "192.168.50.11"
        node1.vm.provider "virtualbox" do |v|
          v.memory = 2048
          v.cpus = 2
        end
    end
end
```

* 脚本命令  

```bash 
## 启动虚拟机
vagrant up
## ssh 登录虚拟机
vagrant ssh 
## 重启虚拟机
vagrant reload
```

## 补充

```BASH 
sed -i 's/^#PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config
sed -i 's/^#UsePAM.*/UsePAM yes/g' /etc/ssh/sshd_config 
sed -i 's/^PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config 
systemctl restart sshd.service

```