# frozen_string_literal: true

require_dependency "decidim/features/namer"

Decidim.register_feature(:dataviz) do |feature|
  feature.engine = Decidim::Dataviz::Engine
  feature.icon = "decidim/dataviz/icon.svg"
  feature.stylesheet = "decidim/dataviz/dataviz"
end
