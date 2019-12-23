- Scripts:
```
#!/bin/bash

IPS="1.1.1.1 2.2.2.2 3.3.3.3"
TABLES='tbl_prd tbl_dev'
PRIVS="select,update,insert,delete"
DB="database_name"
USER="user_name"
PASS="bhAUsdqwr135123tUp"

for ip in $IPS
do
	for t in $TABLES
	do
		if [ "$TABLES" == "all" ]
		then
			t="*"
		fi
		if [ -z $PASS ]
		then
			echo -e "grant $PRIVS on \`$DB\`.\`$t\` to '$USER'@'$ip';"
		else
			echo -e "grant usage on *.* to '$USER'@'$ip' identified by '$PASS' with max_user_connections 20;"
		fi
		echo -e "grant $PRIVS on \`$DB\`.\`$t\` to '$USER'@'$ip';"
	done
done | sort -ur
```
