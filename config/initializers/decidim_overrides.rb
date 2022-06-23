# frozen_string_literal: true

Rails.application.config.to_prepare do
  Decidim::Initiatives::InitiativeMCell.prepend Decidim::Overrides::Initiatives::InitiativeMCell
end
