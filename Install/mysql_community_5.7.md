### 1. Centos
- Step 1 – Enable MySQL Repository:
```
-- On CentOS and RHEL 7 -- 
yum localinstall https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm

-- On CentOS and RHEL 6 -- 
yum localinstall https://dev.mysql.com/get/mysql57-community-release-el6-9.noarch.rpm

-- On Fedora 27 -- 
dnf install https://dev.mysql.com/get/mysql57-community-release-fc27-9.noarch.rpm

-- On Fedora 26 -- 
dnf install https://dev.mysql.com/get/mysql57-community-release-fc26-9.noarch.rpm

-- On Fedora 25 -- 
dnf install https://dev.mysql.com/get/mysql57-community-release-fc25-9.noarch.rpm
```

- Step 2 – Install MySQL 5.7 Server

On CentOS and RHEL 7/6
```
yum install mysql-community-server
```
On Fedora 27/26/25:
```
 dnf install mysql-community-server
```

Get Temporary root Password
```bash
grep 'A temporary password' /var/log/mysqld.log |tail -1
```

- Step 3 - Start MySQL Service
```
service mysqld start
```

- Step 4 - Initial MySQL Configuration
```
/usr/bin/mysql_secure_installation
```

- Step 5 - Validate Mysql Version

```
mysql -V
```

- Step 6 - Login into mysql with command
```
mysql -u root -p
```
with password grep from temporary

then do command for change password first time!
```
SET PASSWORD = PASSWORD('your_new_password');
```

### 2. Ubuntu 18
- Default on Ubuntu 18 is 5.7
```
apt update
apt install mysql-server -y
```

### 3. Ubuntu 20
- Default on Ubuntu 20 is 8.0 so we have to do something
```
wget https://dev.mysql.com/get/mysql-apt-config_0.8.12-1_all.deb
dpkg -i mysql-apt-config_0.8.12-1_all.deb
```
In the prompt, choose Ubuntu Bionic and click Ok. 
The next prompt shows MySQL 8.0 chosen by default. Choose the first option and click OK
In the next prompt, select MySQL 5.7 server and click OK.
The next prompt selects MySQL5.7 by default. Choose the last otpion Ok and click OK

```
apt-get update
apt-cache policy mysql-server
```
Checkout put of cache policy command:
Example output ( version maybe different )
```
     5.7.32-1ubuntu18.04 500
        500 http://repo.mysql.com/apt/ubuntu bionic/mysql-5.7 amd64 Packages
```
Remember this since we will use this for install: `5.7.32-1ubuntu18.04`

```
apt install -f mysql-client=5.7.32-1ubuntu18.04 mysql-community-server=5.7.32-1ubuntu18.04 -y
```
