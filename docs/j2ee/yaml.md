# java中使用yaml文件

## 前言

yaml文件可以作为配置文件，从文件直接转化成为类。本文介绍如何使用snakeyaml来加载配置文件，转换成为对象。


## 代码

* me.yaml

```yaml
age: 1  
name: jiaobuchong
params:   
  event: what's up
  url:  http://www.jiaobuchong.com
favoriteBooks:      
  - Gone with the wind
  - The Little Prince
```

* me.java

```java
import java.util.List;
import java.util.Map;

public class Me {
	private Integer age;
	private String name;
	private Map<String, Object> params;
	private List<String> favoriteBooks;

	public Integer getAge() {
		return age;
	}

	public void setAge(Integer age) {
		this.age = age;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Map<String, Object> getParams() {
		return params;
	}

	public void setParams(Map<String, Object> params) {
		this.params = params;
	}

	public List<String> getFavoriteBooks() {
		return favoriteBooks;
	}

	public void setFavoriteBooks(List<String> favoriteBooks) {
		this.favoriteBooks = favoriteBooks;
	}

	@Override
	public String toString() {
		return "Me{" + "age=" + age + ", name='" + name + '\'' + ", params=" + params + ", favoriteBooks="
				+ favoriteBooks + '}';
	}
}

```

* YamlTest.java

```java
public class YamlTest {
	public static void main(String[] args) throws FileNotFoundException {
		Yaml yaml = new Yaml();
		String path = getXmlPath();
		System.out.println(path);
		
        Me me = yaml.loadAs(new FileInputStream(new File(path+"me.yaml")), Me.class);
        System.out.println(me);
	}
	
    //获取WEB-INT路径，me.yaml放在该路径下
    //如果引用了jar包spring-core,也可使用：
    //Resource resource = new ClassPathResource("weixin_config.properties");
    //resource.getFile();
	  public static String getXmlPath()    
      {    
          String path=Thread.currentThread().getContextClassLoader().getResource("").toString();    
          path=path.replace('/', '\\'); // 将/换成\    
          path=path.replace("file:", ""); //去掉file:    
          path=path.replace("classes\\", ""); //去掉class\    
          path=path.substring(1); //去掉第一个\,如 \D:\JavaWeb...    
          return path;    
      }   
}
```
