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




