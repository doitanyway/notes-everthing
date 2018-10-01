## ansible playbook例子

* 拷贝文件到服务器,[copy模组](https://docs.ansible.com/ansible/latest/modules/copy_module.html?highlight=copy)可参考官网。

```
---
- hosts: webs
  remote_user: root
  tasks: 
  - name: create new path
    shell: echo 'start '
  - name: copy file to remote hosts 
    copy: 
      src: /etc/ansible/down
      dest: ~/
```