# 这里简述xml格式的变更日志
* [参考文章](http://www.liquibase.org/documentation/changeset.html)
## 示例
```
<databaseChangeLog
  xmlns="http://www.liquibase.org/xml/ns/dbchangelog/1.7"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.liquibase.org/xml/ns/dbchangelog/1.7
         http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-1.7.xsd">
        <changeSet id="init-schema" author="zhouyu">
                <comment>init schema</comment>
                <createTable tableName="zhouyu3">
                    <column name="id" type="bigint" autoIncrement="${autoIncrement}">
                        <constraints primaryKey="true" nullable="false"/>
                    </column>
                    <column name="nick_name" type="varchar(255)">
                        <constraints nullable="false"/>
                    </column>
                    <column name="email" type="varchar(255)">
                        <constraints nullable="false"/>
                    </column>
                    <column name="register_time" type="timestamp" defaultValueComputed="CURRENT_TIMESTAMP">
                        <constraints nullable="false"/>
                    </column>
                </createTable>

                <modifySql dbms="mysql">
                    <append value="ENGINE=INNODB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_general_ci"/>
                </modifySql>
         </changeSet>
</databaseChangeLog>
```
## 说明
  - 每个changeSet标记由“id”标记，“author”标记和changelog文件类路径名称的组合唯一标识。id标记仅用作标识符，**它不指示运行更改的顺序，甚至不必是整数**。
  - 已经运行变更日志在数据库默认生成两张表，其中databasechangelog表就是记录每个变更日志变更的表。把变更日志的id/author/filepath插入表中。
  - 当Liquibase执行databaseChangeLog时，它会按顺序读取changeSets，并且对于每一个，通过id和author还有filepath来检查“databasechangelog”表以查看是否已运行。已经运行的会默认跳过。如果你非得已经运行的在执行一遍，那就增加“runAlways”标记。
  