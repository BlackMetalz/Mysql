# Setup Replication for whole Mysql Server

Config mysql file like this. /data of mine is 4Tb and i do have 16Gb Ram for this slave ( master 128Gb ). So i can set
innodb-buffer-pool-size = 12G
It is important to create all folder in config file before start mysql and installed percona tool for mysql server, i also used percona server 5.7 in this case 

If server is ubuntu. Copy this https://github.com/BlackMetalz/Mysql/blob/master/Install/my.cnf.md  to:
## /etc/mysql/conf.d/mysql.cnf ( mysql community server 5.7 )
## /etc/mysql/percona-server.conf.d/mysqld.cnf ( percona server 5.7 )

-- Create folder for change data dir mysql
```
mkdir -p /data/var/lib/mysql
mkdir -p /data/var/log/mysql/mysql-bin/
mkdir -p /data/temp
chown -R mysql: /data/var/lib/mysql /data/var/log/mysql /data/temp
```

Step by step:
Master IP: 10.0.0.254
Slave IP: 10.5.0.253

Step 1:
Slave
```
Delete /data/var/lib/mysql in slave data before sync
cd /data/var/lib/mysql 
nc -l 9999 | xbstream -xv
```

Step 2:
Master
```
innobackupex --stream=xbstream --tmpdir=/data/temp/ /data/temp/ | nc 10.5.0.253 9999
-> completed OK => ok
```

Step 3:
Slave
```
innobackupex --apply-log --use-memory=10G --tmpdir=/data/temp /data/var/lib/mysql
```

Step 4:
Master
```
mysql
create user repl@10.5.0.253 identified by 'slavepassword';
GRANT REPLICATION SLAVE ON *.* TO repl@10.5.0.253;
flush privileges;
```

Step 5
Slave:
```
chown -R mysql: /data/var/
systemctl start mysql
```

Step 6:


Slave:
check binlog for master_log_file and master_log_pos
```
cat /data/var/lib/mysql/xtrabackup_binlog_info

Output example:
mysql-bin.007965        1067196635
```

Step 7:
Slave:
mysql
```
change master to master_host='10.5.0.254',master_user='repl',master_password='slavepassword',master_log_file='mysql-bin.007965',master_log_pos=1067196635;
start slave;
```

-- In case use mysql sock to login
```
ln -s /data/var/lib/mysql/mysql.sock /var/lib/mysql/
```

Master: 
( Need database test available and run this command pt-heartbeat -D test --create-table --check --master-server-id 0254 )
while 0254 is your server-id in my.cnf 
```
perl /usr/bin/pt-heartbeat -D test --update --daemonize
```

## For setup slave from slave in case of you don't want to clone direct from master ( setup 2nd slave )
You only need to change steps belows:

- In step 2: add --slave-info into command
```
innobackupex --stream=xbstream --slave-info --tmpdir=/data/temp/ /data/temp/ | nc 10.5.0.253 9999
```

- Step 6:
check binlog for master_log_file and master_log_pos. 
Cat file xtrabackup_slave_info instead of xtrabackup_binlog_info


## Setup Slave replication delay for disaster recovery:
```
pt-slave-delay --delay 6h --interval 15s localhost & 
```
- Delay 6 hours behind master


# Config Mysql Replication Master-Slave simple. Required binlog enable
- Update config in master : my.cnf
```
server-id=1
log-bin=mysql-bin
```

- Create user 
```bash
CREATE USER replicant@<<slave-server-ip>>;
GRANT REPLICATION SLAVE ON *.* TO replicant@<<slave-server-ip>> IDENTIFIED BY '<<choose-a-good-password>>';
```
- Restart mysqld in Master.

- Dump DB without lock:

```bash
mysqldump --skip-lock-tables --single-transaction --flush-logs --master-data=1 -A > ~/mysqldump.sql
```
- Move file dump to Slave. 

- In slave, import DB
- Config mysql in slave: my.cnf

```bash
server-id=2
binlog-format=mixed
log_bin=/var/lib/mysql/mysql-bin.log
innodb_flush_log_at_trx_commit=1
sync_binlog=1
log-slave-updates = 1
read-only               = 1
```

- restart mysqld in slave.

- Try insert data for testing in master first, after that. Go to mysql console in slave then run command

- Change Master on slave:
```bash
CHANGE MASTER TO MASTER_HOST='server101',MASTER_USER='replicant',MASTER_PASSWORD='Asd@123123',MASTER_LOG_FILE='mysql-bin.000010',MASTER_LOG_POS=120;
```
LOG FILE with LOG POS grep from

```bash
head mysqldump.sql -n80 | grep "MASTER_LOG_POS"
```

Done. This is basic setup Mysql Replication for single database with size is not too big.


