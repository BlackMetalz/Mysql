### Step by step 
- Ubuntu 18 in this case

1.
```
wget https://github.com/openark/orchestrator/releases/download/v3.2.3/orchestrator_3.2.3_amd64.deb
apt install jq -y
dpkg -i orchestrator_3.2.3_amd64.deb
```

2. Setup mysql backend server
```
CREATE DATABASE IF NOT EXISTS orchestrator;
CREATE USER 'orchestrator'@'127.0.0.1' IDENTIFIED BY 'orch_backend_password';
GRANT ALL PRIVILEGES ON `orchestrator`.* TO 'orchestrator'@'127.0.0.1';
```

copy config file into /etc//etc/orchestrator.conf.json

create new file `/etc/mysql/orchestrator_srv.cnf` with content:
```
[client]
user=orchestrator
password=orch_backend_password
```
for matching info in orchestrator config file:
```
  "MySQLOrchestratorHost": "127.0.0.1",
  "MySQLOrchestratorPort": 3306,
  "MySQLOrchestratorDatabase": "orchestrator",
  "MySQLOrchestratorCredentialsConfigFile": "/etc/mysql/orchestrator_srv.cnf",
```

3. Setup mysql topology user:
Imagine we have 2 new fresh mysql server ( percona in this case ):
Run this in both Server: 10.3.48.54 and 10.3.48.56 is 2 mysql server in this example
```
CREATE USER 'orchestrator'@'10.3.48.54' IDENTIFIED BY '123123';
GRANT SUPER, PROCESS, REPLICATION SLAVE, RELOAD ON *.* TO 'orchestrator'@'10.3.48.54';
GRANT SELECT ON mysql.slave_master_info TO 'orchestrator'@'10.3.48.54';
GRANT SUPER, PROCESS, REPLICATION SLAVE, REPLICATION CLIENT, RELOAD ON *.* TO 'orchestrator'@'10.3.48.54';
GRANT SELECT ON meta.* TO 'orchestrator'@'10.3.48.54';

CREATE USER 'orchestrator'@'10.3.48.56' IDENTIFIED BY '123123';
GRANT SUPER, PROCESS, REPLICATION SLAVE, RELOAD ON *.* TO 'orchestrator'@'10.3.48.56';
GRANT SELECT ON mysql.slave_master_info TO 'orchestrator'@'10.3.48.56';
GRANT SUPER, PROCESS, REPLICATION SLAVE, REPLICATION CLIENT, RELOAD ON *.* TO 'orchestrator'@'10.3.48.56';
GRANT SELECT ON meta.* TO 'orchestrator'@'10.3.48.56';


FLUSH PRIVILEGES;
```
note for for grants:
```
# GRANT SELECT ON ndbinfo.processes TO 'orchestrator'@'orc_host'; -- Only for NDB Cluster
# GRANT SELECT ON performance_schema.replication_group_members TO 'orchestrator'@'orc_host'; -- Only for Group Replication / InnoDB cluster
```


4. Discovery
- Start the fucking orchestrator
```
service orchestrator start
```

Let orchestrator know how to query the MySQL topologies, what information to extract.
```json
{
  "MySQLTopologyCredentialsConfigFile": "/etc/mysql/orchestrator-topology.cnf",
  "InstancePollSeconds": 5,
  "DiscoverByShowSlaveHosts": false,
}
```

Setup credentials for topology file
```
[client]
user=orchestrator
password=123123
```

5. DNS Resolver ( dnsmasq )
Guide here: https://www.tecmint.com/setup-a-dns-dhcp-server-using-dnsmasq-on-centos-rhel/
```
apt install dnsmasq -y
systemctl status dnsmasq
systemctl enable dnsmasq
```
Insert to first line of /etc/resolv.conf
```
nameserver 127.0.0.1
```

Content of /etc/dnsmasq.conf:
```
interface=eth0
listen-address=0.0.0.0,127.0.0.1
cache-size=30
# no-resolv
server=8.8.4.4
```

Restart then use dig:
```
dig sys-test-48-54
```

Output:
```
;; ANSWER SECTION:
sys-test-48-54.		0	IN	A	10.3.48.54
```

Done



