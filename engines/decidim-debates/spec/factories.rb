require "decidim/core/test/factories"
require "decidim/admin/test/factories"

FactoryGirl.define do
  factory :debate, class: Decidim::Debates::Debate do
    title { Decidim::Faker::Localized.sentence(3) }
    description { Decidim::Faker::Localized.wrapped("<p>", "</p>") { Decidim::Faker::Localized.sentence(4) } }
    open_date { 1.day.from_now }
    close_date { start_time.advance(hours: 2) }
    feature
  end
end
