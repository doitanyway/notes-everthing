# mysql使用JDBC查询无效


## 问题描述

使用原生jdbc的template,查询一下语句导致没有返回结果：

```java
	String sql="select AmountOwed-RecoveredAmount AS ownedMount from urpcs_blacklistrecord where License='"+license+"' and AmountOwed>RecoveredAmount and TotalSubCentre="+totalSubCentre;
     //查询
     public int getCount(String sql) {
		int count = 0;
		try {
			conn=getConnection();//获取连接
			stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) 
		{
		    LOGGER.error("==JDBC ERROR  [getCount]==sql:"+sql+"; msg:"+e.getMessage());
			e.printStackTrace();
			count = 0;
		}finally{
			closeAll();//关闭连接
		}
		return count;
	}
```

## 原因分析以及解决方案

* 使用了中文查询条件：license，需要将jdbc连接增加utf-8编码支持（如果数据库表使用的该编码）

```
jdbc.url=jdbc\:mysql\://localhost\:3306/urpcs0008??useUnicode=true&characterEncoding=utf8
```

* 使用Statement，中条件的引号需要转移，而且要使用PrepareedsTatement预编译。
* 结果列使用别名
      
```java
         conn=getConnection();//获取连接
            PreparedStatement preparedStatement = conn.prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery();
            boolean next1 = resultSet.next();
            if(next1){
                subcout = resultSet.getInt("ownedMount");
            }
```
