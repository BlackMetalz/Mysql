- Dump with Trigger, routines:
```
mysqldump --events --routines --triggers db_name > db_name.sql
```

- Check slow query / stored function ....
```
Check in mysql slow log
```
How to check slow query log: https://www.a2hosting.com/kb/developer-corner/mysql/enabling-the-slow-query-log-in-mysql


- Count table size in mysql:
```
SELECT TABLE_NAME, table_rows, data_length, index_length, 
round(((data_length + index_length) / 1024 / 1024),2) "Size in MB"
FROM information_schema.TABLES WHERE table_schema = "your_database"
ORDER BY (data_length + index_length) DESC;
```

- Import multiple file to single DB
```
cat *.sql | mysql database
```


- Filter result while in Mysql CLI:
```
pager grep asdasd
```

while asdasd is keyword you need to find. For an example you need to find by mysql thread id which is 123456
```
pager grep 123456
show full processlist;
```

It will display only result that matched to thread id 123456
Whatever command you enter it still filter until you disable it with command below:
```
no pager
```


### Change Mysql Data dir from default to custom location

For several reasons, mysql data location shouldn't in default location:
- OS Die or OS Disk die, but only need to replace disk with new OS and config point to mysql data location
- And so on..... I don't know how to explain :p


1. Stop mysql services first
2. Make changes in mysql configuration ( some default are  /etc/my.cnf )

from something like 
```
/var/lib/mysql
```

to something like

```
/data/var/lib/mysql
```

/data is a mount point for external disk that i won't talk detail in here

3. Sync data
```
cp -r /var/lib/mysql/  /data/var/lib/mysql
```

4. Make sure ever config in my.cnf exists in new location

5. Change owner for new data location to mysql user

```
chown mysql:mysql -R /data/var/lib/mysql
```


6. If something went as expected. Start mysql

```
service mysql start
```

