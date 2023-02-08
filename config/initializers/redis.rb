# frozen_string_literal: true

# rubocop:disable Style/GlobalVars
$redis = Redis.new(url: ENV["REDIS_URL"], ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE }) if Rails.env.production?
# rubocop:enable Style/GlobalVars
