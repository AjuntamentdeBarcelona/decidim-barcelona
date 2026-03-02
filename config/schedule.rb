# frozen_string_literal: true

every 1.day, at: "1:00 am", roles: [:worker] do
  rake "decidim_proposals:upgrade:remove_valuator_orphan_records"
end

every 1.day, at: "2:00 am", roles: [:worker] do
  rake "decidim:open_data:export"
end

every 1.day, at: "7:00 am", roles: [:worker] do
  rake "decidim_initiatives:check_validating"
end

every 1.day, at: "7:30 am", roles: [:worker] do
  rake "decidim_initiatives:check_published"
end

every 1.day, at: "8:00 am", roles: [:worker] do
  rake "decidim_initiatives:notify_progress"
end
