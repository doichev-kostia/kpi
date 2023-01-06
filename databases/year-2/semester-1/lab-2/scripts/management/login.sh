#!/usr/bin/env bash

container_name="db-course"
db_name="school"

read -p "Enter the username: " username

docker exec -ti $container_name bash -c "psql --dbname=$db_name --username=$username"
