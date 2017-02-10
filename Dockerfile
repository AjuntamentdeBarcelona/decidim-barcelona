FROM ruby:2.4.0
MAINTAINER david.morcillo@codegram.com

ARG rails_env=production
ARG secret_key_base=

ENV APP_HOME /code
ENV RAILS_ENV $rails_env
ENV SECRET_KEY_BASE $secret_key_base

RUN apt-get update

ENV LANG C.UTF-8
RUN curl -sL https://deb.nodesource.com/setup_5.x | bash && \
    apt-get install -y nodejs locales

ADD Gemfile /tmp/Gemfile
ADD Gemfile.lock /tmp/Gemfile.lock
ADD ./engines/decidim-debates/decidim-debates.gemspec /tmp/engines/decidim-debates/decidim-debates.gemspec
RUN cd /tmp && bundle install

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
ADD . $APP_HOME

RUN bundle exec rake DATABASE_URL=postgresql://user:pass@127.0.0.1/dbname assets:precompile

CMD ["bundle", "exec", "rails", "s", "-b0.0.0.0"]
