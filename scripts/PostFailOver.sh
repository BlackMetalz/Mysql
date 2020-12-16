#!/bin/bash
# Author: kienlt
# Progress: in developement
MYSQL_USER=orchestrator
MYSQL_PASS=123123
SLAVE_PROMOTE=$1
SLAVE_SECOND=$2
REPL_USER=repl
REPL_PASS=123123

if [ -z $SLAVE_PROMOTE ]; then
	echo "Please enter ip for promote. Exit script now!"
	exit 1
elif [ -z $SLAVE_SECOND ]; then
	echo "Please enter ip for second slave. Exit script now!"
	exit 1
fi

# create connection to slave
echo "Promote $SLAVE_IP to master"
(
echo "stop slave;"
echo "reset slave all;"
echo "SET GLOBAL read_only =0;"
) | mysql -u $MYSQL_USER -p$MYSQL_PASS -h $SLAVE_PROMOTE

if [ $? -eq 0 ]; then
	echo "Promote Master Done"
else
	echo "Promote Master Fail"
	exit 1
fi

# Get new master detail
echo "Getting new master detail"
MASTER_DATA=$(mysql -u $MYSQL_USER -p$MYSQL_PASS -h $SLAVE_PROMOTE -e "show master status;" |tail -n 1)
BIN_LOG=$(echo $MASTER_DATA | awk '{print $1}')
BIN_POS=$(echo $MASTER_DATA | awk '{print $2}')
echo "BIN_LOG: $BIN_LOG"
echo "BIN_POS: $BIN_POS"
echo "Getting detail done"


# Change master of second slave
echo "Change master of second slave now"
echo "change master to master_host='$SLAVE_PROMOTE',master_user='$REPL_USER',master_password='$REPL_PASS',master_log_file='$BIN_LOG',master_log_pos=$BIN_POS;"

(
echo "stop slave;"
echo "reset slave all;"
echo "change master to master_host='$SLAVE_PROMOTE',master_user='$REPL_USER',master_password='$REPL_PASS',master_log_file='$BIN_LOG',master_log_pos=$BIN_POS;"
) | mysql -u $MYSQL_USER -p$MYSQL_PASS -h $SLAVE_SECOND

if [ $? -eq 0 ]; then
	echo "Setup new master for second slave complete"
else
	echo "Setup new master for second slave fail"
	exit 1
fi
