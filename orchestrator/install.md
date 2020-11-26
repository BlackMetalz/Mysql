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
CREATE USER 'orchestrator'@'10.3.48.56' IDENTIFIED BY '123123';
GRANT SUPER, PROCESS, REPLICATION SLAVE, RELOAD ON *.* TO 'orchestrator'@'10.3.48.56';
GRANT SELECT ON mysql.slave_master_info TO 'orchestrator'@'10.3.48.56';
FLUSH PRIVILEGES;
```

4. 

