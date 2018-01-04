source "https://rubygems.org"

ruby '2.4.2'

gem "decidim", "0.8.3"
gem "decidim-debates", path: "decidim-debates"
gem "decidim-dataviz", path: "decidim-dataviz"
gem "decidim-assemblies"
gem "decidim-initiatives", git: "https://github.com/decidim/decidim-initiatives"

gem "virtus-multiparams"

gem 'uglifier'
gem 'lograge'
gem 'faker'
gem "deface"

group :development, :test do
  gem 'byebug', platform: :mri
  gem "decidim-dev"
  gem "bootsnap"
end

group :development do
  gem "progressbar"
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
end

group :test do
  gem "rspec-rails"
  gem "database_cleaner"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
