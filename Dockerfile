FROM ruby:2.6.2-stretch

# Copy application code
COPY . /application
# Change to the application's directory
WORKDIR /application

# Set Rails environment to production
ENV RAILS_ENV production
ENV RAILS_SERVE_STATIC_FILES true

# Install gems, nodejs and precompile the assets
RUN gem install bundler
RUN bundle install \
    && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt install -y nodejs

# Start the application server
ENTRYPOINT ['./entrypoint.sh']
