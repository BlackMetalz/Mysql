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

