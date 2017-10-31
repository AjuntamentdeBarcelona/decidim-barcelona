# frozen_string_literal: true
# Default CarrierWave setup.
#
CarrierWave.configure do |config|
  config.permissions = 0o666
  config.directory_permissions = 0o777
  config.storage = :file
  config.enable_processing = !Rails.env.test?
end

if Rails.application.secrets.aws_access_key_id.present?
  require "carrierwave/storage/fog"

  CarrierWave.configure do |config|
    config.storage = :fog
    config.fog_provider = "fog/aws"                                             # required
    config.fog_credentials = {
      provider:              "AWS",                                             # required
      aws_access_key_id:     Rails.application.secrets.aws_access_key_id,       # required
      aws_secret_access_key: Rails.application.secrets.aws_secret_access_key,   # required
      host:                  "s3-eu-west-1.amazonaws.com",
      endpoint:              "https://s3-eu-west-1.amazonaws.com",
      region:                "eu-west-1"                                     # optional, defaults to 'us-east-1'
    }
    config.fog_directory  = "decidim-barcelona"                                 # required
    config.fog_attributes = { "Cache-Control" => "max-age=#{365.day.to_i}" }    # optional, defaults to {}
    config.asset_host = "https://s3-eu-west-1.amazonaws.com"
  end
end
