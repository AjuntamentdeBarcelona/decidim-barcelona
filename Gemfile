source "https://rubygems.org"

DECIDIM_VERSION = { git: "https://github.com/decidim/decidim", branch: "0.23-fixes" }

ruby RUBY_VERSION

gem "decidim", DECIDIM_VERSION
gem "decidim-dataviz", path: "decidim-dataviz"
gem "decidim-initiatives", DECIDIM_VERSION
gem "decidim-sortitions", DECIDIM_VERSION
gem "decidim-stats", path: "decidim-stats"
gem "decidim-valid_auth", path: "decidim-valid_auth"

# Change term_customizer dependency to ruby-gems' when term-customizer is compatible with DECIDIM_VERSION
gem "decidim-term_customizer", git: "https://github.com/CodiTramuntana/decidim-module-term_customizer"

gem "sassc", "~>2.3.0"

gem "sprockets", "~> 3.7", "< 4"
gem "virtus-multiparams"
gem "wicked_pdf"
gem "wkhtmltopdf-binary"
gem "geocoder", "~> 1.6.1"

gem 'uglifier'
gem 'lograge'
gem "deface"
gem "progressbar"
gem "puma"
gem "origami"

# Needed to be able to debug Puma status
gem "barnes"

# Used to restart puma workers every 6h and free memory
gem "puma_worker_killer"

group :development, :test do
  gem 'faker', '1.9.5'
  gem 'byebug', platform: :mri
  gem "decidim-dev", DECIDIM_VERSION
  gem "bootsnap"
  gem 'dotenv-rails'
end

group :development do
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem "rubocop"
  gem "letter_opener_web"
end

group :production do
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
  gem "rspec-rails"
  gem "database_cleaner"
end
