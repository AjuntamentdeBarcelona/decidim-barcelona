# frozen_string_literal: true

if Rails.application.secrets.sentry_enabled
  Sentry.init do |config|
    config.dsn = ENV["SENTRY_DSN"]
    config.environment = ENV["HEROKU_APP_NAME"].presence || "production"

    config.breadcrumbs_logger = [:active_support_logger]

    config.excluded_exceptions += ["Rack::Timeout::RequestTimeoutException"]
  end
end
