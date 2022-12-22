# frozen_string_literal: true

Rails.application.config.to_prepare do
  Decidim::Initiatives::InitiativeMCell.prepend Decidim::Overrides::Initiatives::InitiativeMCell
  Decidim::TermCustomizer::Context::ControllerContext.prepend Decidim::Overrides::TermsCustomizer::Context::ControllerContext
  Decidim::Accountability::Result.include(Decidim::Accountability::ResultOverride)
  Decidim::Accountability::ResultsCalculator.include(Decidim::Accountability::ResultsCalculatorOverride)
end
