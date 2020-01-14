## 1. Install Percona Mysql in Centos 7

### 1.1 Installing Percona Server from Percona yum repository

`
yum install https://repo.percona.com/yum/percona-release-latest.noarch.rpm -y
`

Output example

`
Retrieving https://repo.percona.com/yum/percona-release-latest.noarch.rpm
Preparing...                ########################################### [100%]
1:percona-release        ########################################### [100%]
`

### 1.2 Testing the repository

Make sure packages are now available from the repository, by executing the following command:

`
yum list | grep percona
`

You should see output similar to the following:

```
...
Percona-Server-57-debuginfo.x86_64      5.7.10-3.1.el7                 @percona-release-x86_64
Percona-Server-client-57.x86_64         5.7.10-3.1.el7                 @percona-release-x86_64
Percona-Server-devel-57.x86_64          5.7.10-3.1.el7                 @percona-release-x86_64
Percona-Server-server-57.x86_64         5.7.10-3.1.el7                 @percona-release-x86_64
Percona-Server-shared-57.x86_64         5.7.10-3.1.el7                 @percona-release-x86_64
Percona-Server-shared-compat-57.x86_64  5.7.10-3.1.el7                 @percona-release-x86_64
Percona-Server-test-57.x86_64           5.7.10-3.1.el7                 @percona-release-x86_64
Percona-Server-tokudb-57.x86_64         5.7.10-3.1.el7                 @percona-release-x86_64
...
```

### 1.3 Install the packages

You can now install Percona Server by running:

`
yum install Percona-Server-server-57 -y
`


## 2. Install Percona Toolkit using the corresponding package manager:
Description: Toolkit have some advantage for manage mysql server

For Debian or Ubuntu:

`
apt-get install percona-toolkit -y
`

For RHEL or CentOS:

`
yum install percona-toolkit -y
`

### 3. Install percona for Ubuntu 18

## 3.1 Fetch the repository packages from Percona web and install

```
wget https://repo.percona.com/apt/percona-release_latest.$(lsb_release -sc)_all.deb
dpkg -i percona-release_latest.$(lsb_release -sc)_all.deb
```

## 3.2 Remember to update the local cache
```
apt update
```

## 3.3 After that you can install the server package
```
apt-get install percona-server-server-5.7
```
