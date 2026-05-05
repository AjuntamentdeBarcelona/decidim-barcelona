# frozen_string_literal: true

Decidim.configure do |config|
  config.timestamp_service = "TimestampService"
  config.pdf_signature_service = "PdfSignatureBarcelona"
  config.sms_gateway_service = "SmsGateway" if ENV["SMS_SERVICE_URL"].present? && ENV["SMS_USERNAME"].present? && ENV["SMS_PASSWORD"].present?

  Decidim::Verifications.register_workflow(:census_sms_authorization_handler) do |auth|
    auth.engine = Decidim::CensusSms::Verification::Engine
    auth.renewable = true
    auth.time_between_renewals = 1.day
    # Uncomment the following line to make the workflow ephemeral
    # auth.ephemeral = true
  end
end

Decidim::Verifications.register_workflow(:census_authorization_handler) do |auth|
  auth.form = "CensusAuthorizationHandler"
  auth.renewable = true
  auth.time_between_renewals = 1.day
  auth.metadata_cell = "census_authorization_metadata"
  # Uncomment the following line to make the workflow ephemeral
  # auth.ephemeral = true

  auth.options do |options|
    district_codes = %w(1 2 3 4 5 6 7 8 9 10)

    district_codes.each do |code|
      options.attribute :"scope_code_#{code}", type: :boolean, required: false
    end
  end

  auth.action_authorizer = "CensusActionAuthorizer"
end

Decidim::Verifications.register_workflow(:census16_authorization_handler) do |auth|
  auth.form = "Census16AuthorizationHandler"
  auth.renewable = true
  auth.time_between_renewals = 1.day
  auth.metadata_cell = "census16_authorization_metadata"
  # Uncomment the following line to make the workflow ephemeral
  # auth.ephemeral = true
end

Decidim::Verifications.register_workflow(:census_kids_authorization_handler) do |auth|
  auth.form = "CensusKidsAuthorizationHandler"
  auth.renewable = true
  auth.time_between_renewals = 1.day
  auth.metadata_cell = "census_kids_authorization_metadata"
end

Decidim::Verifications.register_workflow(:census_sarria_sant_gervasi_authorization_handler) do |auth|
  auth.form = "CensusSarriaSantGervasiAuthorizationHandler"
  auth.renewable = true
  auth.time_between_renewals = 1.day
  auth.metadata_cell = "census_sarria_sant_gervasi_authorization_metadata"
  # Uncomment the following line to make the workflow ephemeral
  # auth.ephemeral = true
end

Decidim::Verifications.register_workflow(:ephemeral_census_authorization_handler) do |auth|
  auth.form = "EphemeralCensusAuthorizationHandler"
  auth.renewable = true
  auth.time_between_renewals = 1.day
  auth.metadata_cell = "ephemeral_census_authorization_metadata"
  auth.ephemeral = true

  auth.options do |options|
    district_codes = %w(1 2 3 4 5 6 7 8 9 10)

    district_codes.each do |code|
      options.attribute :"scope_code_#{code}", type: :boolean, required: false
    end
  end

  auth.action_authorizer = "CensusActionAuthorizer"
end
