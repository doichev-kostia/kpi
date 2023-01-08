#!/usr/bin/env bash

container_name="db-course"
db_name="cinema"
username=postgres

echo "Loading the database dump..."
read -p "Enter the dump file name: " dump_file

docker exec -ti $container_name bash -c "psql --dbname=$db_name --file=/dumps/$dump_file --username=$username --host=localhost --port=5432"
