# frozen_string_literal: true

Decidim.configure do |config|
  config.application_name = "Decidim Barcelona"
  config.mailer_sender    = Rails.application.secrets.email
  config.maximum_attachment_size = 150.megabytes
  config.force_ssl        = true

  config.available_locales = %i(ca es)
  config.default_locale = :ca

  if ENV["HEROKU_APP_NAME"].present?
    config.base_uploads_path = ENV["HEROKU_APP_NAME"] + "/"
  end

  if Rails.application.secrets.geocoder
    config.maps = {
      provider: :here,
      api_key: Rails.application.secrets.geocoder[:here_api_key],
      static: { url: "https://image.maps.ls.hereapi.com/mia/1.6/mapview" }
    }
  end

  if Rails.application.secrets.sms.values.all?(&:present?)
    config.sms_gateway_service = "SmsGateway"

    Decidim::Verifications.register_workflow(:census_sms_authorization_handler) do |auth|
      auth.engine = Decidim::CensusSms::Verification::Engine
      auth.renewable = true
      auth.time_between_renewals = 1.day
      auth.ephemerable = true
    end
  end

  config.timestamp_service = "TimestampService"
  config.pdf_signature_service = "PdfSignatureBarcelona"

  if Rails.application.secrets.etherpad[:server].present?
    config.etherpad = Rails.application.secrets.etherpad
  end
end

Decidim::Verifications.register_workflow(:census_authorization_handler) do |auth|
  auth.form = "CensusAuthorizationHandler"
  auth.renewable = true
  auth.time_between_renewals = 1.day
  auth.metadata_cell = "census_authorization_metadata"
  auth.ephemerable = true

  auth.action_authorizer = "Decidim::CensusSms::Verification::ActionAuthorizer"

  auth.options do |options|
    parent_scope = Decidim::Scope.where("name->>'ca' = 'Ciutat'").first

    Decidim::Scope.where(parent: parent_scope).pluck(:code).each do |code|
      options.attribute :"scope_code_#{code}", type: :boolean, required: false
    end
  end
end

Decidim::Verifications.register_workflow(:census16_authorization_handler) do |auth|
  auth.form = "Census16AuthorizationHandler"
  auth.renewable = true
  auth.time_between_renewals = 1.day
  auth.metadata_cell = "census16_authorization_metadata"
  auth.ephemerable = true
end
