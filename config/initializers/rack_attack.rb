# frozen_string_literal: true

if Rails.env.production? && Decidim::Env.new("RACK_ATTACK_SKIP").present?
  # Provided that trusted users use an HTTP request param named skip_rack_attack
  # with this you can perform apache benchmark test like this:
  # ab -n 2000 -c 20 'https://decidim.url/?skip_rack_attack=some-secret'
  Rack::Attack.safelist("mark any authenticated access safe") do |request|
    # Requests are allowed if the return value is truthy
    request.params["skip_rack_attack"] == Decidim::Env.new("RACK_ATTACK_SKIP").to_s
  end
end

if Rails.env.production?
  # Resource versions are only routed as `/versions/:id` with a positive integer id, and the app
  # never links to anything else. Crawlers request URLs like `.../versions/null`, which boot the
  # whole controller just to raise a RoutingError, so reject them before they reach Rails.
  Rack::Attack.blocklist("invalid resource version ids") do |request|
    request.path.match?(%r{/versions/(?![1-9]\d*(?:\.\w+)?/?\z)[^/]+/?\z})
  end

  Rack::Attack.track(
    "resource versions by ip",
    limit: Decidim::Env.new("RACK_ATTACK_VERSIONS_TRACK_LIMIT", "20").to_i,
    period: 1.minute
  ) do |request|
    request.ip if request.path.match?(%r{/versions/[^/]+/?\z})
  end

  ActiveSupport::Notifications.subscribe("track.rack_attack") do |_name, _start, _finish, _id, payload|
    request = payload[:request]
    next unless request.env["rack.attack.matched"] == "resource versions by ip"

    Rails.logger.warn(
      "[rack-attack] resource versions by ip: ip=#{request.ip} path=#{request.path} user_agent=#{request.user_agent.inspect}"
    )
  end
end
