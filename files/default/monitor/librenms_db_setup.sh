#!/bin/sh
#
# Simple script to create database
#
db_name="librenms"
db_user="librenms"
db_pw="icinga"

/bin/mysqladmin create "$db_name"
cat <<EOF | /bin/mysql 
GRANT ALL PRIVILEGES ON ${db_name}.*
TO '${db_user}'@localhost 
IDENTIFIED BY "${db_pw}";
FLUSH PRIVILEGES;
EOF
exit

# create the database if it does not exist
if echo "show databases;" | /bin/mysql | /bin/grep "^$db_name" ; then
  echo "db already exists"
else
  echo "create the db"
fi

