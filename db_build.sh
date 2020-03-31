#!/bin/bash

docker-compose exec app rake db:create
docker-compose exec app rake db:migrate
