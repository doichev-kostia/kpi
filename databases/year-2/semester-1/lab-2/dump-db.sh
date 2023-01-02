#!/usr/bin/env bash

current_date=$(date +%Y-%m-%d)

file=postgres-$current_date-dump.sql
dir=/dumps
is_exist=$(docker exec -ti lab-2-db bash -c "test -d $dir && echo 1 || echo 0")

if [ "$is_exist" == "0" ]; then
    docker exec -ti lab-2-db bash -c "mkdir $dir"
fi

# Dump the database
docker exec -ti lab-2-db pg_dump --dbname=school --file="$dir"/"$file" --username=postgres --host=localhost --port=5432

echo "Database dumped to $dir/$file"
