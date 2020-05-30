# npm & yarn


|npm|yarn|注释|
|---|---|---|
|npm init|yarn init|初始化某个项目|
|npm install / link	|yarn install/link	|默认的安装全部依赖|
|npm install taco --save	|yarn add taco	|安装某个依赖，并且保存到package.json文件中的dependencies 内；--save和--save-dev，可分别将依赖（或插件）记录到package.json中的dependencies和devDependencies内。|
|npm uninstall taco --save|yarn remove taco	|移除某个依赖|
|npm install taco --save-dev|yarn add taco --dev	|安装某个开发时依赖包|
|npm update tac- --save	|yarn upgrade taco	|更新某个依赖包|
|npm install taco --global 	|yarn global add taco	|全局安装某个依赖|
|npm run / test	|yarn run / test 	|运行某个命令|
|npm install --save axios vue-axios	|yarn add axios vue-axios	|同时下载多个依赖包|