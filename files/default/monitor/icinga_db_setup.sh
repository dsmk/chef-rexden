#!/bin/sh
#
# Simple script to create database
#
db_name="icinga"
db_user="icinga"
db_pw="icinga"

# simple version for now
/bin/mysqladmin create "$db_name"
echo "grant all on ${db_name}.* to ${db_user}@localhost identified by '${db_pw}';" \
  | /bin/mysql 
exit

# create the database if it does not exist
if echo "show databases;" | /bin/mysql | /bin/grep "^$db_name" ; then
  echo "db already exists"
else
  echo "create the db"
fi

