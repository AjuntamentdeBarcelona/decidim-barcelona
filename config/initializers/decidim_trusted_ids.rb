# frozen_string_literal: true

Decidim::TrustedIds.configure do |config|
  # The name of the omniauth provider, must be registered in Decidim.
  config.omniauth_provider = "valid"
  config.omniauth = {
    enabled: true,
    client_id: ENV.fetch("VALID_CLIENT_ID"),
    client_secret: ENV.fetch("VALID_CLIENT_SECRET"),
    site: ENV.fetch("VALID_SITE"),
    scope: "autenticacio_usuari",
    icon: "media/images/valid-icon.png",
    icon_path: "media/images/idcat_mobil-icon.svg"
  }
end
