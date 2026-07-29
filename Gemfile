# frozen_string_literal: true

source "https://rubygems.org"

DECIDIM_VERSION = "~> 0.32.0"

ruby RUBY_VERSION

gem "decidim", DECIDIM_VERSION
gem "decidim-collaborative_texts", DECIDIM_VERSION
gem "decidim-conferences", DECIDIM_VERSION
gem "decidim-elections", DECIDIM_VERSION
gem "decidim-initiatives", DECIDIM_VERSION
gem "decidim-templates", DECIDIM_VERSION

gem "decidim-census_sms", path: "decidim-census_sms"
gem "decidim-dataviz", path: "decidim-dataviz"
gem "decidim-stats", path: "decidim-stats"

gem "decidim-decidim_awesome", git: "https://github.com/decidim-ice/decidim-module-decidim_awesome", branch: "upgrade-32"
# gem "decidim-extra_censuses", git: "https://github.com/openpoke/decidim-module-extra_censuses", branch: "main"
gem "decidim-internal_evaluation", git: "https://github.com/AjuntamentdeBarcelona/decidim-internal-evaluation-module", branch: "deps/decidim-0.32"
gem "decidim-kids", git: "https://github.com/AjuntamentdeBarcelona/decidim-module-kids", branch: "deps/decidim-0.32"
gem "decidim-term_customizer", git: "https://github.com/fblupi/decidim-module-term_customizer", branch: "deps/decidim-0.32"

gem "wicked_pdf", "~> 2.7.0"

gem "progressbar"
gem "puma"

gem "dotenv-rails"

group :development, :test do
  gem "bootsnap"
  gem "byebug", platform: :mri
  gem "decidim-dev", DECIDIM_VERSION
  gem "faker"
  gem "mdl"
  gem "rubocop-faker"

  gem "debug"
  gem "ruby-lsp", require: false
  gem "ruby-lsp-rails", require: false
  gem "ruby-lsp-rspec", require: false
end

group :development do
  gem "foreman"
  gem "letter_opener_web"
  gem "listen"
  gem "rubocop"
  gem "web-console"

  gem "capistrano"
  gem "capistrano3-puma", "~> 8.0"
  gem "capistrano-bundler"
  gem "capistrano-nvm", require: false
  gem "capistrano-rails"
  gem "capistrano-rails-console"
  gem "capistrano-rbenv"
  gem "capistrano-sidekiq"
end

group :production do
  gem "appsignal"
  gem "aws-sdk-s3", require: false
  gem "barnes" # Needed to be able to debug Puma status
  gem "dalli"
  gem "lograge"
  gem "matrix"
  gem "rack_password"
  gem "rack-ssl-enforcer"
  gem "rack-timeout" # Let's kill long-running requests after the Heroku router has responded to
  gem "rails_12factor"
  gem "rails_autoscale_agent"
  gem "rexml"
  gem "sidekiq"
  gem "stackprof"
  gem "whenever", require: false
end

group :test do
  gem "codecov", require: false
  gem "database_cleaner"
  gem "rspec"
end
