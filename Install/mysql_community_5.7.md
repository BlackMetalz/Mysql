### Linux
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

