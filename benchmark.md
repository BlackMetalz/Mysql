-- Install package sysbench

-- Pprepare for table insert and execute it
```
sysbench oltp_read_write --table-size=1000000 --db-driver=mysql --mysql-db=test --mysql-user=root --mysql-password=root prepare
sysbench oltp_read_write --table-size=1000000 --db-driver=mysql --mysql-db=test --mysql-user=root --mysql-password=root --max-time=60  --max-requests=0 --num-threads=8 run
```

Clean up:
```
sysbench oltp_read_write --table-size=1000000 --db-driver=mysql --mysql-db=test --mysql-user=root --mysql-password=root --max-time=60  --max-requests=0 --num-threads=8 run
```


More information:
```
man sysbench
```
