source "https://rubygems.org"

DECIDIM_VERSION = { git: "https://github.com/decidim/decidim", branch: "release/0.21.0" }

ruby '2.6.3'

gem "decidim", DECIDIM_VERSION
gem "decidim-dataviz", path: "decidim-dataviz"
gem "decidim-initiatives", DECIDIM_VERSION
gem "decidim-sortitions", DECIDIM_VERSION
gem "decidim-stats", path: "decidim-stats"
gem "decidim-valid_auth", path: "decidim-valid_auth"

gem "sassc", "~>1.12.0"

gem "sprockets", "~> 3.7", "< 4"
gem "virtus-multiparams"
gem "wicked_pdf"
gem "wkhtmltopdf-binary"
gem "geocoder", "~> 1.5.2"

gem 'uglifier'
gem 'lograge'
gem 'faker'
gem "deface"
gem "progressbar"
gem "puma"
gem "origami"

group :development, :test do
  gem 'byebug', platform: :mri
  gem "decidim-dev", DECIDIM_VERSION
  gem "bootsnap"
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
  gem "newrelic_rpm"
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
