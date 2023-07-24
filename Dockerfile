# Decidim Application Dockerfile
# This is an image to start an application based on Decidim (https://decidim.org)
#
#


# Starts with a clean ruby image from Debian (slim)
FROM ruby:3.0.2

LABEL maintainer="hola@decidim.org"

# Installs system dependencies
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    graphviz \
    imagemagick \
    libicu-dev \
    libpq-dev \
    nodejs \
    && rm -rf /var/lib/apt/lists/*

# Sets workdir as /app
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
ADD ./decidim-ephemeral_participation/decidim-ephemeral_participation.gemspec /app/decidim-ephemeral_participation/decidim-ephemeral_participation.gemspec
ADD ./decidim-stats/decidim-stats.gemspec /app/decidim-stats/decidim-stats.gemspec
ADD ./decidim-valid_auth/decidim-valid_auth.gemspec /app/decidim-valid_auth/decidim-valid_auth.gemspec
RUN gem install bundler:2.3.26
RUN bundle install

# Copy all the code to /app
ADD . /app
