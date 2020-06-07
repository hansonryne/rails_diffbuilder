#!/bin/sh
echo "Installing new gems if needed"
bundle check || bundle install

echo "Copying node cache"
rsync -q -av --progress /home/railsuser/node_cache/. /home/railsuser/app/
echo "Waiting for PG to be ready"
sleep 3

echo "Creating database..."
bundle exec rake db:create
echo "Running database migrations..."
bundle exec rake db:migrate

#echo "Precompiling webpack assets"
#bundle exec rake assets:precompile

echo "Removing any old server pids"
rm -f /home/railsuser/app/tmp/pids/server.pid

echo "Starting rails server"
bundle exec rails s -b 0.0.0.0
