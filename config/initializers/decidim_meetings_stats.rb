# frozen_string_literal: true

Decidim.find_component_manifest(:meetings).stats.register(
  :meetings_attendees_count,
  priority: Decidim::StatsRegistry::MEDIUM_PRIORITY,
  admin: false,
  icon_name: "group-line",
  tooltip_key: "meetings_attendees_count_tooltip"
) do |components, start_at, end_at|
  Decidim.find_component_manifest(:meetings).stats.resolve(:attendees_count, components, start_at, end_at)
end
