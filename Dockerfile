FROM ruby:3.2.6

ENV DEBIAN_FRONTEND noninteractive
ENV NODE_MAJOR=18

# Install system dependencies
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    graphviz \
    imagemagick \
    libicu-dev \
    libpq-dev \
    nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install node
RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
RUN apt-get update -qq && apt-get install -y \
    nodejs \
    && rm -rf /var/lib/apt/lists/*

# Create workdir
RUN mkdir /app
WORKDIR /app

# Installs bundler dependencies
ENV \
  BUNDLE_BIN=/usr/local/bundle/bin \
  BUNDLE_JOBS=10 \
  BUNDLE_PATH=/usr/local/bundle \
  BUNDLE_RETRY=3 \
  GEM_HOME=/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"

# Copy Gemfile and install bundler dependencies
ADD Gemfile Gemfile.lock /app/
ADD ./decidim-census_sms/decidim-census_sms.gemspec /app/decidim-census_sms/decidim-census_sms.gemspec
ADD ./decidim-dataviz/decidim-dataviz.gemspec /app/decidim-dataviz/decidim-dataviz.gemspec
ADD ./decidim-stats/decidim-stats.gemspec /app/decidim-stats/decidim-stats.gemspec
ADD ./decidim-valid_auth/decidim-valid_auth.gemspec /app/decidim-valid_auth/decidim-valid_auth.gemspec
RUN gem install bundler:2.4.19
RUN bundle install

# Copy all the code to /app
ADD . /app

# Compile assets
RUN npm i
RUN npm i -g yarn
