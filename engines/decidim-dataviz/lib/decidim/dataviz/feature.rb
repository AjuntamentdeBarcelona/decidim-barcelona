# frozen_string_literal: true

require_dependency "decidim/features/namer"

Decidim.register_feature(:dataviz) do |feature|
  feature.engine = Decidim::Dataviz::Engine
  feature.admin_engine = Decidim::Dataviz::AdminEngine
  feature.icon = "decidim/dataviz/icon.svg"
end
