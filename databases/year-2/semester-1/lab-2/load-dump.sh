#!/usr/bin/env bash

echo "Loading the database dump..."
read -p "Enter the dump file name: " dump_file

docker exec -ti lab-2-db bash -c "psql --dbname=school --file=/dumps/$dump_file --username=postgres --host=localhost --port=5432"
