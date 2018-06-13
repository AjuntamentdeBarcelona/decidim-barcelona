require "importer"

namespace :import do
  task :results => :environment do
    data = Importer.read_file("results")

    ActiveRecord::Base.transaction do
      Decidim::Results::Result.delete_all
      Decidim::Component.where(manifest_name: "results").delete_all

      progress_bar = Importer.progress_bar("Results", data.length)

      data.each do |result_data|
        process = Decidim::ParticipatoryProcess.where(id: result_data.fetch("process_id")).first
        component = create_results_component(process)
        scope = Decidim::Scope.where(id: result_data.fetch("scope_id")).first

        mirrored_keys = [
          :id, :created_at, :updated_at, :extra
        ]

        mirrored_attributes = mirrored_keys.inject({}) do |result, attribute|
          result.update(attribute => result_data.fetch(attribute.to_s))
        end

        result = Decidim::Results::Result.create!(
          mirrored_attributes.merge(
            id: result_data.fetch("id"),
            title: Importer.fake_i18n(result_data.fetch("title")),
            description: Importer.fake_i18n("<p>#{result_data.fetch("description")}</p>"),
            category: Importer.category_from(
              result_data.fetch("category_id"),
              result_data.fetch("subcategory_id")
            ),
            scope: scope,
            component: component
          )
        )

        result.link_resources(
          Decidim::Proposals::Proposal.where(id: result_data.fetch("proposal_ids")),
          "included_proposals"
        )

        meeting_ids = result.linked_resources(:proposals, "included_proposals").flat_map do |proposal|
          proposal.linked_resources(:meetings, "proposals_from_meeting").pluck(:id)
        end.uniq

        result.link_resources(Decidim::Meetings::Meeting.where(id: meeting_ids), "meetings_through_proposals")

        progress_bar.increment
      end

      Importer.fix_auto_increment("decidim_results_results")
    end
  end

  def create_results_component(process)
    component = Decidim::Component.find_or_initialize_by(
      manifest_name: "results",
      participatory_process: process
    )

    unless component.persisted?
      component.name = { ca: "Actuacions", es: "Actuaciones"}
      component.save!
    end

    component
  end
end
