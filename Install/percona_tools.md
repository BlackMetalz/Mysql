### Install Percona Toolkit using the corresponding package manager:
Description: Toolkit have some advantage for manage mysql server

For Debian or Ubuntu 18:

```
apt install percona-toolkit percona-xtrabackup-24 -y
```
For Ubuntu 20 ( using mysql community ) with same 
```
wget https://downloads.percona.com/downloads/Percona-XtraBackup-2.4/Percona-XtraBackup-2.4.21/binary/debian/focal/x86_64/percona-xtrabackup-24_2.4.21-1.focal_amd64.deb
apt install -f ./percona-xtrabackup-24_2.4.21-1.focal_amd64.deb  -y
```

For RHEL or CentOS:

```
yum install percona-toolkit percona-xtrabackup-24 -y
```
