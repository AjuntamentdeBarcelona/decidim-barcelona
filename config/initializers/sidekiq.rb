# frozen_string_literal: true

if Rails.env.production?
  Sidekiq.configure_server do |config|
    config.redis = { url: ENV.fetch("REDIS_URL", nil), ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE } }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: ENV.fetch("REDIS_URL", nil), ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE } }
  end

  Sidekiq.strict_args!(false)
end
