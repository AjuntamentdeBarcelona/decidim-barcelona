source "https://rubygems.org"

MAIN_BRANCH = "feature/bcn-budget-v0.24"

FEATURE_BRANCHES = {
  pb04: "feature/pb04-budget-scope-list",
  pb05: "feature/pb05-alt"
}.freeze

DECIDIM_VERSION = { git: "https://github.com/AjuntamentdeBarcelona/decidim", branch: MAIN_BRANCH }.freeze

ruby '2.7.2'

gem "decidim", DECIDIM_VERSION
gem "decidim-dataviz", path: "decidim-dataviz"
gem "decidim-initiatives", DECIDIM_VERSION
gem "decidim-sortitions", DECIDIM_VERSION
gem "decidim-stats", path: "decidim-stats"
gem "decidim-valid_auth", path: "decidim-valid_auth"
gem "decidim-ephemeral_participation", path: "decidim-ephemeral_participation"
gem "decidim-navigation_maps", "~> 1.2.0"

# Change term_customizer dependency to ruby-gems' when term-customizer is compatible with DECIDIM_VERSION
gem "decidim-term_customizer", git: "https://github.com/CodiTramuntana/decidim-module-term_customizer"

gem "sassc", "~> 2.4.0"

gem "sprockets", "~> 3.7", "< 4"
gem "virtus-multiparams"
gem "wicked_pdf", "~> 1.4"
gem "wkhtmltopdf-binary"
gem "geocoder", "~> 1.6.1"

gem 'uglifier'
gem 'lograge'
gem "deface"
gem "progressbar"
gem "puma"
gem "origami"

gem "execjs", "~> 2.7.0"

group :development, :test do
  gem 'faker', '2.14.0'
  gem 'byebug', platform: :mri
  gem "decidim-dev", DECIDIM_VERSION
  gem "bootsnap"
  gem 'dotenv-rails'
end

group :development do
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem "rubocop", "~> 0.92.0"
  gem "letter_opener_web"
end

group :production do
  # can be removed after
  gem "letter_opener_web"
  gem "sidekiq"
  gem "rails_12factor"
  gem "fog-aws"
  gem "dalli"
  gem "sentry-raven"
  gem 'rack-ssl-enforcer'
  gem 'rails_autoscale_agent'
  gem "rack_password"
  gem "scout_apm"
end

group :test do
  gem "rspec-rails", "~> 3.7"
  gem "database_cleaner"
end
