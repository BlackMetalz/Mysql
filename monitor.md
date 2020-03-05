# Monitor with percona tool
- Install plugin based centos or ubuntu
```
yum install percona-nagios-plugins
or
apt-get install nagios-plugins-contrib
```
- I'm lazy right now, read this
https://www.percona.com/doc/percona-monitoring-plugins/LATEST/nagios/index.html





- Basic mrpe

```
MySQL::InnoDB::idle_blocker_duration /usr/lib/nagios/plugins/pmp-check-mysql-innodb -C idle_blocker_duration
MySQL::InnoDB::waiter_count /usr/lib/nagios/plugins/pmp-check-mysql-innodb -C waiter_count
MySQL::InnoDB::max_duration /usr/lib/nagios/plugins/pmp-check-mysql-innodb -C max_duration -c 1000 -w 1200
MySQL::pidfile /usr/lib/nagios/plugins/pmp-check-mysql-pidfile
MySQL::processlist::states_count /usr/lib/nagios/plugins/pmp-check-mysql-processlist -C states_count
MySQL::processlist::max_user_conn /usr/lib/nagios/plugins/pmp-check-mysql-processlist -C max_user_conn
MySQL::replication-delay /usr/lib/nagios/plugins/pmp-check-mysql-replication-delay -T test.heartbeat -s 2343 -w 600 -c 900
MySQL::replication-running /usr/lib/nagios/plugins/pmp-check-mysql-replication-running
```
