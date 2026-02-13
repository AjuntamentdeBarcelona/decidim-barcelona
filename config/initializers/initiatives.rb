# frozen_string_literal: true

Decidim::Initiatives.configure do |config|
  config.face_to_face_voting_allowed = true
  config.online_voting_allowed = true
  config.default_signature_time_period_length = 60
  config.creation_enabled = true
end

Decidim::Initiatives::Signatures.register_workflow(:ephemeral_census_authorization) do |workflow|
  workflow.form = "CensusSignatureHandler"
  workflow.authorization_handler_form = "InitiativeCensusAuthorizationHandler"
  workflow.ephemeral = true
  workflow.promote_authorization_validation_errors = true
end
