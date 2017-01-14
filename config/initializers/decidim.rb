# frozen_string_literal: true
Decidim.configure do |config|
  config.application_name = "Decidim Barcelona"
  config.mailer_sender    = Rails.application.secrets.email
  config.authorization_handlers = [ExampleAuthorizationHandler]

  config.available_locales = %i(en ca es)
end
