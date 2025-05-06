# frozen_string_literal: true

Decidim::TrustedIds.configure do |config|
  # The name of the omniauth provider, must be registered in Decidim.
  config.omniauth_provider = "valid"
  config.omniauth = {
    enabled: true,
    client_id: Rails.application.secrets.dig(:omniauth, :valid, :client_id),
    client_secret: Rails.application.secrets.dig(:omniauth, :valid, :client_secret),
    site: Rails.application.secrets.dig(:omniauth, :valid, :site).presence || "https://valid-pre.aoc.cat",
    scope: "autenticacio_usuari",
    icon_path: Rails.application.secrets.dig(:omniauth, :valid, :icon_path).presence || "media/images/idcat_mobil-icon.svg"
  }
end
