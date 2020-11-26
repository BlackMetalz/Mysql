### 1.Mysql Max openfile ( in case of use percona mysql server )
```
[root@1234 ~]# cat /proc/1234567/limits
Limit                     Soft Limit           Hard Limit           Units     
Max cpu time              unlimited            unlimited            seconds   
Max file size             unlimited            unlimited            bytes     
Max data size             unlimited            unlimited            bytes     
Max stack size            8388608              unlimited            bytes     
Max core file size        0                    unlimited            bytes     
Max resident set          unlimited            unlimited            bytes     
Max processes             256054               256054               processes 
Max open files            1024                 4096                 files     
Max locked memory         16777216             16777216             bytes     
Max address space         unlimited            unlimited            bytes     
Max file locks            unlimited            unlimited            locks     
Max pending signals       256054               256054               signals   
Max msgqueue size         819200               819200               bytes     
Max nice priority         0                    0                    
Max realtime priority     0                    0                    
Max realtime timeout      unlimited            unlimited            us        

```
Change it to :
```
[root@1234 ~]# prlimit --nofile=100000:100000 --pid 1234567
```


Add 
```
LimitNOFILE=900000
```
into systemd mysql file: /lib/systemd/system/mysql.service


### 2. Select multiple user based username
```
mysql> select concat("SELECT * from mysql.user where user=","'",user,"' and host=","'",host,"';") from mysql.user where user='orc_client';
+-------------------------------------------------------------------------------------+
| concat("SELECT * from mysql.user where user=","'",user,"' and host=","'",host,"';") |
+-------------------------------------------------------------------------------------+
| SELECT * from mysql.user where user='orc_client' and host='10.3.48.54';             |
| SELECT * from mysql.user where user='orc_client' and host='10.3.48.56';             |
| SELECT * from mysql.user where user='orc_client' and host='10.3.48.82';             |
```
