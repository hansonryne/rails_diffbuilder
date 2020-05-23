FROM ruby:alpine3.10

RUN apk add --update --no-cache \
      bash \
      binutils-gold \
      build-base \
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

# Create and define the node_modules's cache directory.
RUN mkdir -p /node_cache
WORKDIR /node_cache

# Install the application's dependencies into the node_modules's cache directory.
COPY package.json ./
RUN yarn install

RUN adduser -D railsuser
USER railsuser
# Create and define the application's working directory.
WORKDIR /app

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

COPY . ./

ENTRYPOINT ["./entrypoint.sh"]
