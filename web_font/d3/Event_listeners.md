# Event listeners

## 知识

* selection.on(eventType,callback)
* d3.event
* selection.append(tagName)                     //添加内容
* selection.propery(name[,newValue]);           //读写属性
* selection.remove                              //删除元素


## 代码

* 起步代码 

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Event Listeners in D3</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <h1>My notes.</h1>
  <div id="notes">
    <p class="note">
      Need to go to the store.
    </p>
    <p class="note">
      What's the name of that movie with that guy?
    </p>
    <p class="note">
      Here's another note.
    </p>
  </div>
  <form id="new-note">
    <input type="text">
    <button>Add Note</button>
  </form>
  <script src="https://d3js.org/d3.v4.js"></script>
</body>
</html>
```

```css
body {
  background-color: #e4e4e4;
}

h1 {
  text-align: center;
}

#notes {
  margin: 0 auto;
  width: 75%;
}

.note {
  background-color: #fdffb7;
  border: 8px solid #d4daa7;
  border-radius: 8px;
  padding: 10px;
}

form {
  text-align: center;
}

input {
  width: 50%;
}

input,
button {
  padding: 10px;
}

button {
  background-color: #ff9494;
  border: none;
  border-radius: 5px;
}

button:hover {
  cursor: pointer;
  background-color: #fe2222;
}

button:focus {
  outline: none;
}
```


* 添加listener    

```js
d3.select("h1").on("click",function(){
	console.log("event listeners");
});
```

* 删除listener

```js
d3.select("h1").on("click",null);
```

* 添加新的按钮事件

```js
d3.select("#new-note").on("submit",function(){
	d3.event.preventDefault();
	
	var input = d3.select("input");

	if(input.property("value")==="")
		return ;
	d3.select("#notes")
		.append("p")
		.classed("note",true)
		.text(input.property("value"));
	input.property("value","");
	
});
```

* 删除元素

```js
d3.selectAll("p").remove();
```
