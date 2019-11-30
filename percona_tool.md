-  Add Column: 

--dry-run : for test
--execute : for real

```
pt-online-schema-change --defaults-file=/root/.my.cnf --alter="add column group_id bigint(20)" D=db_name,t=table_name  --dry-run
```

- Add indexes:

```
pt-online-schema-change --defaults-file=/root/.my.cnf --alter="add index idx_user_group_version (user_id,group_id,version_crc)" D=db_name,t=table_name  --dry-run
```

- Alter column
```
pt-online-schema-change --defaults-file=/root/.my.cnf --alter="modify group_id bigint(20) default 1" D=db_name,t=table_name  --dry-run
```
