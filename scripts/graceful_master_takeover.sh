#!/bin/bash
# Author: kienlt
# Progress: in developement
MYSQL_USER=orchestrator
MYSQL_PASS=123123
CURRENT_MASTER=$1
NEW_MASTER=$2
SLAVE_SECOND=$3
REPL_USER=repl_user
REPL_PASS=123123

echo "Start checking args"

if [ -z "$CURRENT_MASTER" ]; then
        echo "Please enter ip for current master"
        exit 1
elif [ -z "$NEW_MASTER" ]; then
        echo "Please enter ip for new master"
        exit 1
elif [ -z "$SLAVE_SECOND" ]; then
	echo "Please enter ip for second slave"
	exit 1
fi


# create connection to slave
echo "Promote $NEW_MASTER to new master from Current master $CURRENT_MASTER"
(
echo "stop slave;"
echo "reset slave all;"
echo "SET GLOBAL read_only=0;"
) | mysql -u $MYSQL_USER -p$MYSQL_PASS -h $NEW_MASTER

if [ $? -eq 0 ]; then
        echo "Promote Master Done"
else
        echo "Promote Master Fail"
        exit 1
fi

# Get new master detail
echo "Getting new master detail"
MASTER_DATA=$(mysql -u $MYSQL_USER -p$MYSQL_PASS -h $NEW_MASTER -e "show master status;" |tail -n 1)
BIN_LOG=$(echo $MASTER_DATA | awk '{print $1}')
BIN_POS=$(echo $MASTER_DATA | awk '{print $2}')
echo "BIN_LOG: $BIN_LOG"
echo "BIN_POS: $BIN_POS"
echo "Getting detail done"

echo "Switching old master to slave"
(
echo "stop slave;"
echo "reset slave all;"
echo "change master to master_host='$NEW_MASTER',master_user='$REPL_USER',master_password='$REPL_PASS',master_log_file='$BIN_LOG',master_log_pos=$BIN_POS;"
echo "SET GLOBAL read_only=1;"
echo "start slave;"
) | mysql -u $MYSQL_USER -p$MYSQL_PASS -h $CURRENT_MASTER

if [ $? -eq 0 ]; then
        echo "Switching old master to slave complete"
else
        echo "Switching old master to slave fail"
        exit 1
fi

echo "Switching slave to new master"
(
echo "stop slave;"
echo "reset slave all;"
echo "change master to master_host='$NEW_MASTER',master_user='$REPL_USER',master_password='$REPL_PASS',master_log_file='$BIN_LOG',master_log_pos=$BIN_POS;"
echo "SET GLOBAL read_only=1;"
echo "start slave;"
) | mysql -u $MYSQL_USER -p$MYSQL_PASS -h $SLAVE_SECOND

if [ $? -eq 0 ]; then
        echo "Switching slave to new master complete"
else
        echo "Switching slave to new master fail"
        exit 1
fi
