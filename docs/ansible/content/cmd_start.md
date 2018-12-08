##  ansible命令入门

* /etc/ansible/hosts

```
192.168.1.196 ansible_ssh_user=root
```

* 测试是否联通
```
ansible all -m ping
```

* 如果我们想使用sudo模式运行，可以参考如下命令

```
# as bruce
$ ansible all -m ping -u bruce
# as bruce, sudoing to root
$ ansible all -m ping -u bruce --sudo
# as bruce, sudoing to batman
$ ansible all -m ping -u bruce --sudo --sudo-user batman

# With latest version of ansible `sudo` is deprecated so use become
# as bruce, sudoing to root
$ ansible all -m ping -u bruce -b
# as bruce, sudoing to batman
$ ansible all -m ping -u bruce -b --become-user batman
```


* 服务器上执行echo 

```
ansible all -a "/bin/echo hello"
```

