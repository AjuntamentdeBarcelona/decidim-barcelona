# frozen_string_literal: true

if Decidim::Env.new("VALID_AUTH_URL").present?
  Decidim::Verifications.register_workflow(:valid_auth) do |workflow|
    workflow.engine = Decidim::ValidAuth::Engine
  end
end
