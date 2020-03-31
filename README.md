# README

### Description
A tool to help with differential code review.

## Docker Installation

Clone and move into the repository

```
git clone https://github.com/hansonryne/rails_diffbuilder
cd rails_diffbuilder
```

Configure environment files (.env)
```
touch .env
```

Add the following environment variables to .env
```
# These values should be changed to a more secure value and then updated to match in the init.sql file in this repository
DATABASE_USER=sammy
DATABASE_PASSWORD=shark

DATABASE_NAME=diffbuilder_db
DATABASE_HOST=database

REDIS_HOST=redis #not currently being used

RAILS_ENV=production
#RAILS_ENV=development

RAILS_SERVE_STATIC_FILES=true

# You should make this better too
SECRET_KEY_BASE=supers3cr3tpassword
```

Build and run containers
```
docker-compose build
docker-compose up -d
```

Run rake commands for database configuration (if needed)

```
docker-compose run app rake db:create
docker-compose run app rake db:migrate
```

**App should be running on localhost:3000**

When you are done, shut down and clean up with docker-compose
```
docker-compose down
```

Database should remain in docker volumes
