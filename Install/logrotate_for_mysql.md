/etc/logrotate.d/mysql:

content:
```
/data/mysql/var/log/mysql/mysql-slow.log {
    nocompress
    create 660 mysql mysql
    size 1G
    dateext
    dateformat -%Y-%m-%d-%s
    missingok
    notifempty
    sharedscripts
    postrotate
       /usr/bin/mysql -e 'select @@global.long_query_time into @lqt_save; set global long_query_time=2000; select sleep(2); FLUSH LOGS; select sleep(2); set global long_query_time=@lqt_save;'
    endscript
    rotate 30
}
```
