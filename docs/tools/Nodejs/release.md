# 发布




## 配置发布仓库

* package.json中添加

```json
  "publishConfig": {
    "registry": "https://registry.yarnpkg.com"
  },
```

## 想上传的文件

* package.json中添加

```json
  "files": [
    "dist"
  ],
```

## 配置发布前执行钩子

* package.json中添加


```json
  "scripts": {
    "clean": "rimraf ./dist",
    "start": "react-scripts start",
    "build": "npm run clean && npm run build-ts && npm run build-css",
    "build-ts": "tsc -p tsconfig.build.json",
    "build-css": "node-sass ./src/styles/index.scss ./dist/index.css",
    "test": "react-scripts test",
    "eject": "react-scripts eject",
    "prepublish": "npm run build"
  },
```

## 发布命令


```bash 
npm publish
```