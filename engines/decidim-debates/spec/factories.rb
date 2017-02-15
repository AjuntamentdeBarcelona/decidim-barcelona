# frozen_string_literal: true
require "decidim/core/test/factories"
require "decidim/admin/test/factories"

FactoryGirl.define do
  factory :debate, class: Decidim::Debates::Debate do
    title { Decidim::Faker::Localized.sentence(3) }
    description { Decidim::Faker::Localized.wrapped("<p>", "</p>") { Decidim::Faker::Localized.sentence(4) } }
    instructions { Decidim::Faker::Localized.wrapped("<p>", "</p>") { Decidim::Faker::Localized.sentence(4) } }
    start_time { 1.day.from_now }
    end_time { start_time.advance(hours: 2) }
    feature { build(:feature, manifest_name: "debates") }
  end
end
