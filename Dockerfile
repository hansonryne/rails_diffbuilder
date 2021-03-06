FROM ruby:alpine3.10

RUN apk add --update --no-cache \
      bash \
      binutils-gold \
      build-base \
      chromium \
      chromium-chromedriver \
      curl \
      file \
      g++ \
      gcc \
      git \
      less \
      libstdc++ \
      libffi-dev \
      libc-dev \
      linux-headers \
      libxml2-dev \
      libxslt-dev \
      libgcrypt-dev \
      make \
      netcat-openbsd \
      nodejs \
      openssl \
      pkgconfig \
      postgresql-dev \
      python \
      rsync \
      tzdata \
      vim \
      yarn

RUN adduser -D railsuser

RUN mkdir /home/railsuser/app
#RUN mkdir -p /home/railsuser/.webdrivers
#RUN cp /usr/bin/chromedriver /home/railsuser/.webdrivers/chromedriver

# Create and define the node_modules's cache directory.
RUN mkdir -p /home/railsuser/node_cache
WORKDIR /home/railsuser/node_cache

# Install the application's dependencies into the node_modules's cache directory.
COPY package.json ./
RUN yarn install && yarn upgrade
RUN chown -R railsuser:railsuser /home
USER railsuser

# Create and define the application's working directory.
WORKDIR /home/railsuser/app

RUN mkdir -p /home/railsuser/gems
#Point Bundler at /home/railsuser/gems. This will cause Bundler to re-use gems that have already been installed on the gems volume
ENV BUNDLE_PATH=/home/railsuser/gems
ENV BUNDLE_HOME=/home/railsuser/gems

# Increase how many threads Bundler uses when installing. Optional!
ENV BUNDLE_JOBS=20
# How many times Bundler will retry a gem download. Optional!
ENV BUNDLE_RETRY=3

# Where Rubygems will look for gems, similar to BUNDLE_ equivalents.
ENV GEM_HOME=/home/railsuser/gems
ENV GEM_PATH=/home/railsuser/gems

RUN gem install bundler -v 2.1.4
RUN gem install rails
RUN gem install foreman

COPY . ./
USER root
RUN chown -R railsuser:railsuser ./*
USER railsuser

ENTRYPOINT ["./entrypoint.sh"]
