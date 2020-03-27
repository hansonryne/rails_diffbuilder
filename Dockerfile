FROM ruby:alpine3.11

RUN apk add --update --no-cache \
      bash \
      bash-completion \
      binutils-gold \
      build-base \
      curl \
      file \
      g++ \
      gcc \
      git \
      git-bash-completion \
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
      sqlite-dev \
      tzdata \
      vim \
      yarn

#Point Bundler at /gems. This will cause Bundler to re-use gems that have already been installed on the gems volume
ENV BUNDLE_PATH /gems
ENV BUNDLE_HOME /gems 

# Increase how many threads Bundler uses when installing. Optional!
ENV BUNDLE_JOBS 4 
# How many times Bundler will retry a gem download. Optional!
ENV BUNDLE_RETRY 3 

# Where Rubygems will look for gems, similar to BUNDLE_ equivalents.
ENV GEM_HOME /gems
ENV GEM_PATH /gems 

# You'll need something here. For development, you don't need anything super secret.
ENV SECRET_KEY_BASE development123 

# Add /gems/bin to the path so any installed gem binaries are runnable from bash.
ENV PATH /gems/bin:$PATH 

RUN gem install bundler 
RUN gem install rails

COPY yarn.lock package.json ./
RUN yarn install

COPY Gemfile Gemfile.lock ./
RUN bundle install

RUN rails db:create
RUN rails db:migrate

# Allow SSH keys to be mounted (optional, but nice if you use SSH authentication for git)
#VOLUME /root/.ssh 
# Setup the directory where we will mount the codebase from the host
VOLUME /app

WORKDIR /app 

CMD rails s -b 0.0.0.0



