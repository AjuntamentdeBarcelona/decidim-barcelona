# frozen_string_literal: true

require_dependency "decidim/features/namer"

Decidim.register_feature(:debates) do |feature|
  feature.engine = Decidim::Debates::ListEngine
  feature.admin_engine = Decidim::Debates::AdminEngine
  feature.icon = "decidim/debates/icon.svg"

  feature.on(:before_destroy) do |instance|
    raise StandardError, "Can't remove this feature" if Decidim::Debates::Debate.where(feature: instance).any?
  end

  feature.seeds do
    Decidim::ParticipatoryProcess.all.each do |process|
      next unless process.steps.any?

      feature = Decidim::Feature.create!(
        name: Decidim::Features::Namer.new(process.organization.available_locales, :debates).i18n_name,
        manifest_name: :debates,
        participatory_process: process
      )

      3.times do
        debate = Decidim::Debates::Debate.create!(
          feature: feature,
          scope: process.organization.scopes.sample,
          category: process.categories.sample,
          title: Decidim::Faker::Localized.sentence(2),
          description: Decidim::Faker::Localized.wrapped("<p>", "</p>") do
            Decidim::Faker::Localized.paragraph(3)
          end,
          short_description: Decidim::Faker::Localized.wrapped("<p>", "</p>") do
            Decidim::Faker::Localized.paragraph(3)
          end,
          location: Decidim::Faker::Localized.sentence,
          location_hints: Decidim::Faker::Localized.sentence,
          start_time: 3.weeks.from_now,
          end_time: 3.weeks.from_now + 4.hours,
          address: "#{Faker::Address.street_address} #{Faker::Address.zip} #{Faker::Address.city}"
        )

        Decidim::Comments::Seed.comments_for(debate)
      end
    end
  end
end
