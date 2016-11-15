#!/bin/bash

cd bin

# Waits for MySQL database in container 'motowebui_db' to be fully operational
while ! mysqladmin ping -h motowebui_db --silent; do
    sleep 1
done

rails assets:precompile
rails db:migrate
rails db:seed
rails server -b 0.0.0.0 -e production
