## Personal Note while working with that error:
### For Backup:

- While using mysql dump command. It needed to be this, if not you will faced error 
```
mysqldump --single-transaction --events --triggers --routines db_name > db_name.sql
```
### For Restore:

- Remove line from file which contains word lock/ unlock tables
```
sed -i '/LOCK TABLES/d' db_backup.sql
```
- Check to make sure it has been removed
```
grep 'LOCK TABLES' db_backup.sql
```

- After that import like normal and you won't face this error

```
[root@DB-pxc-33 test]# mysql db_name < db_name.sql
ERROR 1105 (HY000) at line 59: Percona-XtraDB-Cluster prohibits use of LOCK TABLE/FLUSH TABLE <table> WITH READ LOCK/FOR EXPORT 
with pxc_strict_mode = ENFORCING
```

### Extra note:
- While i'm importing this file has ~20Gb size. So it need to be run on Screen if you don't want get ssh session disconnected
while importing
- It is recommend that install and use pipe view for importing progress

- Command import with pipe view
```
pv sqlfile.sql | mysql db_name
```
