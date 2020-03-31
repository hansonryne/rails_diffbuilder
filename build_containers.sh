#!/bin/bash

echo "Building and setting up"
docker-compose up -d --build
echo "..."
docker-compose exec app rake db:create
docker-compose exec app rake db:migrate
echo "..."
docker-compose down
echo "Done"

