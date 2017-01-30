# frozen_string_literal: true
require_relative "../../app/services/census_authorization_handler"

Decidim.configure do |config|
  config.application_name = "Decidim Barcelona"
  config.mailer_sender    = Rails.application.secrets.email
  config.authorization_handlers = [CensusAuthorizationHandler]
  config.maximum_attachment_size = 150.megabytes

  config.available_locales = %i(en ca es)

  if Rails.application.secrets.geocoder
    config.geocoder = {
      here_app_id: Rails.application.secrets.geocoder["here_app_id"],
      here_app_code: Rails.application.secrets.geocoder["here_app_code"]
    }
  end
end
