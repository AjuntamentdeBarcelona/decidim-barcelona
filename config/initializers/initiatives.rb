# frozen_string_literal: true

Decidim::Initiatives.configure do |config|
  config.face_to_face_voting_allowed = true
  config.online_voting_allowed = true
  config.default_signature_time_period_length = 60
  config.creation_enabled = true
end
