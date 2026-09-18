# frozen_string_literal: true

Decidim::Initiatives.default_signature_time_period_length = 60
Decidim::Initiatives.creation_enabled = true

Decidim::Initiatives::Signatures.register_workflow(:ephemeral_census_authorization) do |workflow|
  workflow.form = "CensusSignatureHandler"
  workflow.authorization_handler_form = "InitiativeCensusAuthorizationHandler"
  workflow.ephemeral = true
  workflow.promote_authorization_validation_errors = true
end
