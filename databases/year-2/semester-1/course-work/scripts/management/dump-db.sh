#!/usr/bin/env bash

current_date=$(date +%Y-%m-%d)
container_name="db-course"
db_name="cinema"
username=postgres

file=postgres-$current_date-dump.sql
dir=/dumps
is_exist=$(docker exec -ti $container_name bash -c "test -d $dir && echo 1 || echo 0")

if [ "$is_exist" == "0" ]; then
    docker exec -ti $container_name bash -c "mkdir $dir"
fi

# Dump the database
docker exec -ti $container_name pg_dump --dbname=$db_name --file="$dir"/"$file" --username=$username --host=localhost --port=5432

echo "Database dumped to $dir/$file"
