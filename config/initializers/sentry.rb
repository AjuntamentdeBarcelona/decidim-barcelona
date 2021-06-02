if Rails.application.secrets.sentry_enabled
  Sentry.init do |config|
    config.dsn = ENV["SENTRY_DSN"]
    config.environment = if ENV["HEROKU_APP_NAME"].present?
                           ENV["HEROKU_APP_NAME"]
                         else
                           "production"
                         end

    config.breadcrumbs_logger = [:active_support_logger]

    config.excluded_exceptions += ["Rack::Timeout::RequestTimeoutException"]
  end
end
