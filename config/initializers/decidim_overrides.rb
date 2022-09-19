# frozen_string_literal: true

Rails.application.config.to_prepare do
  Decidim::Initiatives::InitiativeMCell.prepend Decidim::Overrides::Initiatives::InitiativeMCell
  Decidim::TermCustomizer::Context::ControllerContext.prepend Decidim::Overrides::TermsCustomizer::Context::ControllerContext
end
