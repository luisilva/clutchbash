#!/bin/bash
user=
pass=

db_list=($(mysql -u $user -p$pass -e 'show databases;' |awk '{print $1}' |egrep -v "information_schema|mysql|Database"))

for i in "${db_list[@]}"
do
  echo $i
  mysql -u $user -p$pass -e "SELECT UPDATE_TIME FROM information_schema.tables WHERE TABLE_SCHEMA = '$i' ORDER BY UPDATE_TIME DESC"
done
