# frozen_string_literal: true

source "https://rubygems.org"

DECIDIM_VERSION = { git: "https://github.com/AjuntamentdeBarcelona/decidim", branch: "feature/proposal-voting" }.freeze

ruby RUBY_VERSION

gem "decidim", DECIDIM_VERSION
gem "decidim-initiatives", DECIDIM_VERSION
gem "decidim-sortitions", DECIDIM_VERSION
gem "decidim-templates", DECIDIM_VERSION

gem "decidim-census_sms", path: "decidim-census_sms"
gem "decidim-dataviz", path: "decidim-dataviz"
gem "decidim-ephemeral_participation", path: "decidim-ephemeral_participation" # Installed but not used anymore
gem "decidim-stats", path: "decidim-stats"

gem "decidim-decidim_awesome", git: "https://github.com/decidim-ice/decidim-module-decidim_awesome", branch: "main"
gem "decidim-internal_evaluation", git: "https://github.com/AjuntamentdeBarcelona/decidim-internal-evaluation-module", branch: "main"
# gem "decidim-kids", git: "https://github.com/AjuntamentdeBarcelona/decidim-module-kids", branch: "main"
gem "decidim-navigation_maps", git: "https://github.com/Platoniq/decidim-module-navigation_maps", branch: "main"
gem "decidim-term_customizer", git: "https://github.com/Platoniq/decidim-module-term_customizer", branch: "master"
gem "decidim-vocdoni", git: "https://github.com/Platoniq/decidim-module-vocdoni", branch: "main"

gem "origami"
gem "wicked_pdf"

gem "progressbar"
gem "puma"

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
  gem "web-console"
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
