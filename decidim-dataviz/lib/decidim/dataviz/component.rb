# frozen_string_literal: true

require_dependency "decidim/components/namer"

Decidim.register_component(:dataviz) do |component|
  component.engine = Decidim::Dataviz::Engine
  component.icon = "decidim/dataviz/icon.svg"
  component.stylesheet = "decidim/dataviz/dataviz"
end
