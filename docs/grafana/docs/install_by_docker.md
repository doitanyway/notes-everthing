# docker 安装 granfa

## 安装 granfa

- 安装 granfa

```bash
# 运行grafana容器
docker run -d --name=grafana -p 3000:3000 grafana/grafana:7.2.0

# 通过参数安装默认的grafana插件
# docker run -d \
# -p 3000:3000 \
# --name=grafana \
# -e "GF_INSTALL_PLUGINS=grafana-clock-panel,grafana-simple-json-datasource" \
# grafana/grafana

```

- 浏览器打开 http://loalhost:3000,默认用户/密码 admin/admin

> 更多的使用方法https://grafana.com/docs/grafana/latest/installation/docker/
