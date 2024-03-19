# frozen_string_literal: true

source "https://rubygems.org"

DECIDIM_VERSION = "~> 0.28.0"

ruby RUBY_VERSION

gem "decidim", DECIDIM_VERSION
gem "decidim-initiatives", DECIDIM_VERSION
gem "decidim-sortitions", DECIDIM_VERSION

gem "decidim-census_sms", path: "decidim-census_sms"
gem "decidim-ephemeral_participation", path: "decidim-ephemeral_participation"
gem "decidim-stats", path: "decidim-stats"
gem "decidim-valid_auth", path: "decidim-valid_auth"

# gem "decidim-decidim_awesome", git: "https://github.com/decidim-ice/decidim-module-decidim_awesome", branch: "main"
# gem "decidim-kids", git: "https://github.com/AjuntamentdeBarcelona/decidim-module-kids", branch: "main"
# gem "decidim-navigation_maps", git: "https://github.com/Platoniq/decidim-module-navigation_maps", branch: "main"
gem "decidim-term_customizer", git: "https://github.com/mainio/decidim-module-term_customizer"

gem "wicked_pdf"
gem "wkhtmltopdf-binary"

gem "deface"
gem "lograge"
gem "origami"
gem "progressbar"
gem "puma"
gem "uglifier"

# Needed to be able to debug Puma status
gem "barnes"

group :development, :test do
  gem "bootsnap"
  gem "byebug", platform: :mri
  gem "decidim-dev", DECIDIM_VERSION
  gem "dotenv-rails"
  gem "faker"
  gem "mdl"
  gem "rubocop-faker"
end

group :development do
  gem "foreman"
  gem "letter_opener_web"
  gem "listen"
  gem "rubocop"
  gem "spring"
  gem "spring-commands-rspec"
  gem "spring-watcher-listen"
  gem "web-console"
end

group :production do
  # Used to restart puma workers every 6h and free memory
  gem "puma_worker_killer"
  # Let's kill long-running requests after the Heroku router has responded to.
  # https://devcenter.heroku.com/articles/h12-request-timeout-in-ruby-mri#rack-timeout
  gem "aws-sdk-s3", require: false
  gem "dalli"
  gem "fog-aws" # to remove once image migration is complete
  gem "matrix"
  gem "rack_password"
  gem "rack-ssl-enforcer"
  gem "rack-timeout"
  gem "rails_12factor"
  gem "rails_autoscale_agent"
  gem "rexml"
  gem "scout_apm"
  gem "sentry-rails"
  gem "sentry-ruby"
  gem "sentry-sidekiq"
  gem "sidekiq"
  gem "stackprof"
end

group :test do
  gem "codecov", require: false
  gem "database_cleaner"
  gem "rspec"
end
