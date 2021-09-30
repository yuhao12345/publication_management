#!/bin/bash

if [ $# -lt 2 ]; then
    echo "You should call this script via $0 <cnetID> <assignedServerHost>"
    exit
fi

cmd="psql -h $2 -P pager=off  -U $1 $1 -f drop_tables.sql"
echo $cmd
$cmd
cmd="psql -h $2 -P pager=off  -U $1 $1 -f create_db.sql"
echo $cmd
$cmd
cmd="psql -h $2 -P pager=off  -U $1 $1 -f populate_db_large.sql"
echo $cmd
$cmd
cmd="psql -h $2 -P pager=off  -U $1 $1 -f count.sql"
echo $cmd
$cmd
cmd="psql -h $2 -P pager=off  -U $1 $1 -f query6.sql"
echo $cmd
$cmd
cmd="psql -h $2 -P pager=off  -U $1 $1 -f index6.sql"
echo $cmd
$cmd