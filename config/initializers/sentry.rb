# frozen_string_literal: true

if Rails.application.secrets.sentry_enabled
  Sentry.init do |config|
    config.dsn = ENV.fetch("SENTRY_DSN", nil)
    config.traces_sample_rate = ENV.fetch("SENTRY_TRACES_SAMPLE_RATE", "0.5").to_f
    config.profiles_sample_rate = ENV.fetch("SENTRY_PROFILES_SAMPLE_RATE", "0.5").to_f
    config.environment = ENV["HEROKU_APP_NAME"].presence || "production"

    config.breadcrumbs_logger = [:active_support_logger]

    config.excluded_exceptions += ["Rack::Timeout::RequestTimeoutException"]
  end
end
