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
