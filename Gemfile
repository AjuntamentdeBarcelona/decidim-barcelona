source "https://rubygems.org"

ruby '2.4.1'

gem "decidim"
gem "decidim-debates", path: "decidim-debates"
gem "decidim-dataviz", path: "decidim-dataviz"
gem "decidim-accountability", git: "https://github.com/decidim/decidim-accountability.git"

gem 'uglifier', '>= 1.3.0'
gem 'lograge'
gem 'faker'
gem 'rack_password'

group :development, :test do
  gem 'byebug', platform: :mri
  gem "decidim-dev"
end

group :development do
  gem "progressbar"
  gem 'rainbow', "~>2.2.0"
  gem 'web-console'
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
end

group :test do
  gem "rspec-rails"
  gem "database_cleaner"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
