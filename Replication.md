# Config Mysql Replication Master-Slave
- Update config in master : my.cnf
```bash
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

Done. This is basic setup Mysql Replication for single database with size is not too big. ( Recommend for <= 500Mb )



# replication for big data > 100G ( in my case 1.2Tb raw data )

Config mysql file like this. /data of mine is 4Tb and i do have 16Gb Ram for this slave ( master 128Gb ). So i can set
innodb-buffer-pool-size = 12G
It is important to create all folder in config file before start mysql and installed percona tool for mysql server, i also used percona server 5.7 in this case 
```
[mysql]

# CLIENT #
port                           = 3306
socket                         = /data/var/lib/mysql/mysql.sock

[mysqld]

# GENERAL #
user                           = mysql
default-storage-engine         = InnoDB
socket                         = /data/var/lib/mysql/mysql.sock
pid-file                       = /data/var/lib/mysql/mysql.pid

# MyISAM #
key-buffer-size                = 32M
#myisam-recover                 = FORCE,BACKUP

# SAFETY #
max-allowed-packet             = 16M
max-connect-errors             = 1000000
skip-name-resolve
sysdate-is-now                 = 1
secure-file-priv = ""
sql_mode                       = "STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION"

# DATA STORAGE #
datadir                        = /data/var/lib/mysql/

# BINARY LOGGING #
log-bin                        = /data/var/log/mysql/mysql-bin/mysql-bin
expire-logs-days               = 1
sync-binlog                    = 0
server-id                      = 4835
log_bin_trust_function_creators = 1

# REPLICATION #
#event-scheduler                 = 0
#read-only                       = 1
#skip-slave-start                = 1
#relay-log                       = /data/var/log/mysql/relay-bin/relay-bin

# CACHES AND LIMITS #
tmp-table-size                 = 32M
max-heap-table-size            = 32M
query-cache-type               = 0
query-cache-size               = 0
max-connections                = 500
thread-cache-size              = 50
open-files-limit               = 65535
table-definition-cache         = 4096
table-open-cache               = 4096

# INNODB #
innodb-flush-method            = O_DIRECT
innodb-log-files-in-group      = 2
innodb-log-file-size           = 256M
innodb-flush-log-at-trx-commit = 0
innodb-file-per-table          = 1
innodb-buffer-pool-size        = 12G
#innodb-io-capacity             = 2000
#innodb-page-size               = 4K #Best optimize for SSD, Default: 16K, Bug with index key larger 768 bytes
#innodb_force_recovery = 2

# LOGGING #
log-error                      = /data/var/log/mysql/mysql-error.log
log-queries-not-using-indexes  = 1
slow-query-log                 = 1
slow-query-log-file            = /data/var/log/mysql/mysql-slow.log
#long_query_time = 10
```


Step by step:

```
Delete slave data before sync
slave:
cd /data/var/lib/mysql 
nc -l 9999 | xbstream -xv

master:
innobackupex --stream=xbstream --tmpdir=/data/temp/ /data/temp/ | nc 10.5.0.1 9999
-> completed OK - là ok

slave:
innobackupex --apply-log --use-memory=10G --tmpdir=/data/temp /data/var/lib/mysql

master:
mysql -e "create user repl@10.5.0.1 identified by '123123';"
mysql -e "GRANT REPLICATION SLAVE ON *.* TO repl@10.5.0.1;"
mysql -e "flush privileges;"

slave:
chown -R mysql: /data/var/lib/mysql
systemctl start mysqld

check binlog:
cat /data/var/lib/mysql/xtrabackup_binlog_info
mysql-bin.007965        1067196635

mysql
mysql > change master to master_host='192.168.1.1',master_user='repl',master_password='123123',master_log_file='mysql-bin.007965',master_log_pos=1067196635;
mysql >    start slave;


mysql sock
ln -s /data/var/lib/mysql/mysql.sock /var/lib/mysql/

Master: 
( Need database test available and run this command pt-heartbeat -D test --create-table --check --master-server-id 23191 )
while 23191 is your server-id in my.cnf 

perl /usr/bin/pt-heartbeat -D test --update --daemonize
```
