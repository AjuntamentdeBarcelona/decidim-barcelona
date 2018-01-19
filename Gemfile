source "https://rubygems.org"

DECIDIM_VERSION = "0.8.4"

ruby '2.4.2'

gem "decidim", DECIDIM_VERSION
gem "decidim-debates", path: "decidim-debates"
gem "decidim-dataviz", path: "decidim-dataviz"
gem "decidim-assemblies", DECIDIM_VERSION
gem "decidim-initiatives", git: "https://github.com/decidim/decidim-initiatives"

gem "virtus-multiparams"

gem 'uglifier'
gem 'lograge'
gem 'faker'
gem "deface"
gem "progressbar"

group :development, :test do
  gem 'byebug', platform: :mri
  gem "decidim-dev", DECIDIM_VERSION
  gem "bootsnap"
end

group :development do
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
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
