# mac安装kinba


## 安装步骤


```bash 
# 下载并安装kibana
curl -O https://artifacts.elastic.co/downloads/kibana/kibana-7.13.1-darwin-x86_64.tar.gz
curl https://artifacts.elastic.co/downloads/kibana/kibana-7.13.1-darwin-x86_64.tar.gz.sha512 | shasum -a 512 -c - 
tar -xzf kibana-7.13.1-darwin-x86_64.tar.gz
cd kibana-7.13.1-darwin-x86_64/ 

# 修改kibana的配置文件 $KIBANA_HOME/config/kibana.yml
# 启动kibana
./bin/kibana

```