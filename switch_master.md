Script: Master IP 1.2 | Slave IP 1.3 | VIP IP: 3.4

-- MASTER 1.2
ip addr del 192.168.3.4/32 dev eth3
mysql -e "FLUSH LOGS;"

-- SLAVE: 1.3
mysql -e "STOP SLAVE;"
mysql -e "RESET SLAVE ALL;"
set read-only = 0 in /etc/my.cnf
restart mysql
ip addr add 192.168.3.4 dev eth0
apring -I eth0 -c 10 192.168.3.4
