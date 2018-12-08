# 添加vscode右键菜单   
添加项目右键用vscode打开

> 新电脑用vscode发现不能右键打开vscode，感觉很麻烦，于是有课下文；可能是Windows上面安装Visual Studio Code忘记勾选等原因,没有将"Open with Code(右键快捷方式)"添加到鼠标右键菜单里

* 新建reg文件；在vscode安装目录下新建一个文本文件,然后将文件后缀改为:*.reg,文件名任意,例如:add_vscode.reg。
* 编写文本文件内容.将下面的内容Copy到刚才新建的*.reg文件中,文本内容如下:  
```
    Windows Registry Editor Version 5.00
        
    [HKEY_CLASSES_ROOT\*\shell\VSCode]
    @="Open with Code"
    "Icon"="D:\\tools\\Microsoft VS Code\\Code.exe"
        
    [HKEY_CLASSES_ROOT\*\shell\VSCode\command]
    @="\"D:\\tools\\Microsoft VS Code\\Code.exe\" \"%1\""
        
    Windows Registry Editor Version 5.00
        
    [HKEY_CLASSES_ROOT\Directory\shell\VSCode]
    @="Open with Code"
    "Icon"="D:\\tools\\Microsoft VS Code\\Code.exe"
        
    [HKEY_CLASSES_ROOT\Directory\shell\VSCode\command]
    @="\"D:\\tools\\Microsoft VS Code\\Code.exe\" \"%V\""
        
    Windows Registry Editor Version 5.00
        
    [HKEY_CLASSES_ROOT\Directory\Background\shell\VSCode]
    @="Open with Code"
    "Icon"="D:\\tools\\Microsoft VS Code\\Code.exe"
        
    [HKEY_CLASSES_ROOT\Directory\Background\shell\VSCode\command]
    @="\"D:\\tools\\Microsoft VS Code\\Code.exe\" \"%V\"" 
```
    本人的安装目录在D盘，读者需要替换相应路径   

* 文件编辑好了之后保存关闭.然后双击运行 add_vscode.reg ,遇到提示点击 "确定"或"是"；
* 在项目文件夹中，右键打开vscode。。。