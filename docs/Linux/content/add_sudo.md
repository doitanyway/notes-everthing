# 给普通用户添加sudo权限

```bash
chmod a+w /etc/sudoers
echo "appuser ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
chmod a-w /etc/sudoers
su appuser
```