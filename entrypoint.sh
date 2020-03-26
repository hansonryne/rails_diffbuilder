# Compile the assets
bundle exec rake assets:precompile

# Create and migrate database
bundle exec rake db:create db:migrate

# Start the server
bundle exec rails server
