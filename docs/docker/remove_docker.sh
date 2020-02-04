#!/bin/bash

# 错误退出  
set -e

systemctl disable docker
rm -rf /etc/docker
rm -rf /usr/lib/systemd/system/docker.service
rm -rf /usr/local/bin/docker*