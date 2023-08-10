# frozen_string_literal: true

require_dependency "decidim/components/namer"

Decidim.register_component(:dataviz) do |component|
  component.engine = Decidim::Dataviz::Engine
  component.admin_engine = Decidim::Pages::AdminEngine
  component.icon = "media/images/decidim/dataviz/icon.svg"
end
