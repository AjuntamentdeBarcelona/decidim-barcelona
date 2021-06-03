# frozen_string_literal: true

if Rails.env.production? && Rails.application.secrets.rack_attack_skip.present?
  # Provided that trusted users use an HTTP request param named skip_rack_attack
  # with this you can perform apache benchmark test like this:
  # ab -n 2000 -c 20 'https://decidim.url/?skip_rack_attack=some-secret'
  Rack::Attack.safelist("mark any authenticated access safe") do |request|
    # Requests are allowed if the return value is truthy
    request.params["skip_rack_attack"] == Rails.application.secrets.rack_attack_skip
  end
end
