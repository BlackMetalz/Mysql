-- Demo
-- Have to create folder first

innodb-buffer-pool-size = 80% Server RAM


```
mkdir -p /data/var/lib/mysql
mkdir -p /data/var/log/mysql-bin
```

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
myisam-recover-options         = FORCE,BACKUP

# SAFETY #
max-allowed-packet             = 16M
max-connect-errors             = 1000000
skip-name-resolve
sysdate-is-now                 = 1
#innodb                         = FORCE
#sql-mode                       = "ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION"
secure-file-priv               = ""

# DATA STORAGE #
datadir                        = /data/var/lib/mysql/

# BINARY LOGGING #
log-bin                        = /data/var/log/mysql/mysql-bin/mysql-bin
expire-logs-days               = 1
sync-binlog                    = 0
server-id                      = 12
log_bin_trust_function_creators = 1

# REPLICATION #
#event-scheduler               = 0
#read-only                      = 1
#skip-slave-start               = 1
#relay-log                      = /data/var/log/mysql/relay-bin/relay-bin
#slave-parallel-type            = LOGICAL_CLOCK
#slave-parallel-workers         = 8

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
innodb-log-file-size           = 512M
innodb-flush-log-at-trx-commit = 2
innodb-file-per-table          = 1
innodb-buffer-pool-size        = 12G
innodb-io-capacity             = 2000
innodb-flush-log-at-timeout    = 1800
slave-parallel-type            = LOGICAL_CLOCK
slave-parallel-workers         = 8

# LOGGING #
log-error                      = /data/var/log/mysql/mysql-error.log
#log-queries-not-using-indexes  = 1
slow-query-log                 = 0
#long_query_time                = 0
slow-query-log-file            = /data/var/log/mysql/mysql-slow.log

```