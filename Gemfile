source "https://rubygems.org"

ruby '2.4.0'

gem "decidim", git: "https://github.com/AjuntamentdeBarcelona/decidim.git", branch: "refactor_authorizations"

gem 'puma', '~> 3.0'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'byebug', platform: :mri
end

group :development do
  gem "decidim-dev", git: "https://github.com/AjuntamentdeBarcelona/decidim.git", branch: "refactor_authorizations"
  gem 'web-console'
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'faker'
end

group :production do
  gem "rails_12factor"
  gem "fog-aws"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
