## 1. Install Percona Mysql in Centos 7

### 1.1 Installing Percona Server from Percona yum repository

`
yum install https://repo.percona.com/yum/percona-release-latest.noarch.rpm -y
yum install Percona-Server-server-57 -y
`

## 2. Install percona for Ubuntu 18

### 2.1 Fetch the repository packages from Percona web and install

```
wget https://repo.percona.com/apt/percona-release_latest.$(lsb_release -sc)_all.deb
apt install gnupg2 -y
dpkg -i percona-release_latest.$(lsb_release -sc)_all.deb
apt update
apt-get install percona-server-server-5.7 -y
echo ":v"
```


### Install Percona Toolkit using the corresponding package manager:
Description: Toolkit have some advantage for manage mysql server

For Debian or Ubuntu:

```
apt install percona-toolkit percona-xtrabackup-24 -y
```

For RHEL or CentOS:

```
yum install percona-toolkit percona-xtrabackup-24 -y
```
