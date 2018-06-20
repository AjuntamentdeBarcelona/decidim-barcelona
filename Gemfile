source "https://rubygems.org"

DECIDIM_VERSION = "~> 0.12.0"

ruby '2.5.0'

gem "decidim", git: "https://github.com/decidim/decidim.git", branch: "0.12-stable"
gem "decidim-dataviz", path: "decidim-dataviz"
gem "decidim-initiatives", git: "https://github.com/decidim/decidim.git", branch: "0.12-stable"
gem "decidim-sortitions", git: "https://github.com/decidim/decidim.git", branch: "0.12-stable"

gem "virtus-multiparams"

gem 'uglifier'
gem 'lograge'
gem 'faker'
gem "deface"
gem "progressbar"
gem "puma"

group :development, :test do
  gem 'byebug', platform: :mri
  gem "decidim-dev", git: "https://github.com/decidim/decidim.git", branch: "0.12-stable"
  gem "bootsnap"
end

group :development do
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem "rubocop"
end

group :production do
  gem "passenger"
  gem "sidekiq"
  gem "rails_12factor"
  gem "fog-aws"
  gem "newrelic_rpm"
  gem "dalli"
  gem "sentry-raven"
  gem 'rack-ssl-enforcer'
  gem 'rails_autoscale_agent'
  gem "rack_password"
end

group :test do
  gem "rspec-rails"
  gem "database_cleaner"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
