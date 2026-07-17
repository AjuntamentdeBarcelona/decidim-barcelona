# frozen_string_literal: true

Decidim.find_component_manifest(:meetings).stats.register(
  :in_person_attendees_count,
  priority: Decidim::StatsRegistry::MEDIUM_PRIORITY,
  admin: false,
  icon_name: "group-line",
  tooltip_key: "in_person_attendees_count_tooltip"
) do |components, _start_at, _end_at|
  Decidim::Meetings::Meeting.closed.not_hidden.published
                            .where(component: components, closing_visible: true)
                            .in_person
                            .sum(:attendees_count)
end
