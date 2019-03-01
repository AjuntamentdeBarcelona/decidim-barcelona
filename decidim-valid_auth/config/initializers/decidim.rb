if Rails.application.secrets.valid_auth_url
  Decidim::Verifications.register_workflow(:valid_auth) do |workflow|
    workflow.engine = Decidim::ValidAuth::Engine
  end
end