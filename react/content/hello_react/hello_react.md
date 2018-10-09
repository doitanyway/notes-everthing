## 第一个react组建

本文实现第一个react组建



### 第一次实现

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Component 1</title>
    <script src="https://unpkg.com/react@16.0.0/umd/react.development.js"></script>
    <script src="https://unpkg.com/react-dom@16.0.0/umd/react-dom.development.js"></script>
    <script src="https://unpkg.com/react-dom-factories@1.0.0/index.js"></script>
</head>
<body>
  <div id="app"></div>
  <script type="text/javascript">
    class Pet extends React.Component {
      render() {
        const h2 = ReactDOMFactories.h2(null, "Moxie");
        const img = ReactDOMFactories.img({
          src: "https://github.com/tigarcia/Moxie/raw/master/moxie.png"
        });
        const cardDiv = ReactDOMFactories.div(null, h2, img);
        return cardDiv;
      }
    }

    ReactDOM.render(React.createElement(Pet),
                    document.getElementById("app"));
  </script>
</body>
</html>

```

### 使用jsx改造

JSX就是Javascript和XML结合的一种格式。React发明了JSX，利用HTML语法来创建虚拟DOM。当遇到<，JSX就当HTML解析，遇到{就当JavaScript解析。
下面通过bibel组建解析jsx

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Component 2</title>
    <script src="https://unpkg.com/react@16.0.0-rc.2/umd/react.development.js"></script>
    <script src="https://unpkg.com/react-dom@16.0.0-rc.2/umd/react-dom.development.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.26.0/babel.js"></script>
</head>
<body>
  <div id="app"></div>
  <script type="text/babel">
    class Pet extends React.Component {
      render() {
        return (<div>
                  <h2>Moxie</h2>
                  <img src="https://github.com/tigarcia/Moxie/raw/master/moxie.png" />
                </div>);
      }
    }

    ReactDOM.render(<Pet />, document.getElementById("app"));
  </script>
</body>
</html>

```

### jsx完善

之前的页面，没有style我们稍微美化一下。添加一个css文件，并引用相关样式；

* [first-component3.html](first-component3.html)
* [first-component.css](first-component.css)


```js
 class Pet extends React.Component {
      render() {
        const style = {fontSize: '1.5em'};
        return (<div className="card">
                  <h2 className="name">Moxie</h2>
                  <img src="https://github.com/tigarcia/Moxie/raw/master/moxie.png" />
                  <h5 style={{fontSize: '2em', margin: '2px'}}>Hobbies:</h5>
                  <ul>
                    <li style={style}>Sleeping</li>
                    <li style={style}>Eating</li>
                  </ul>
                </div>);
      }
    }
```

关键代码如上：
* 定义变量``const style = {fontSize: '1.5em'};``,在下面通过一个花括号引用样式；
* 直接使用2个花括号引用样式；``<h5 style={{fontSize: '2em', margin: '2px'}}>Hobbies:</h5>``
* 通过className应用css文件定义的class`` <h2 className="name">Moxie</h2>``