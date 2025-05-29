# frozen_string_literal: true

Appsignal.configure do |config|
  config.name = ENV.fetch("APPSIGNAL_APP_NAME", "DecidimBarcelona")
  config.push_api_key = ENV.fetch("APPSIGNAL_PUSH_API_KEY", nil)
  config.environment = ENV.fetch("APPSIGNAL_APP_ENV", "production")
  config.active = Rails.env.production?
  config.revision = `git rev-parse --short HEAD`.strip
end
