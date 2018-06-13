require "importer"

namespace :import do
  task :meetings => :environment do
    data = Importer.read_file("meetings")

    ActiveRecord::Base.transaction do
      Decidim::Meetings::Meeting.delete_all
      Decidim::Component.where(manifest_name: "meetings").delete_all

      progress_bar = Importer.progress_bar("Meetings", data.length)

      data.each do |meeting_data|
        process = Decidim::ParticipatoryProcess.where(id: meeting_data.fetch("process_id")).first
        component = create_meetings_component(process)
        scope = Decidim::Scope.where(id: meeting_data.fetch("scope_id")).first

        mirrored_keys = [
          :start_time, :end_time, :latitude, :longitude, :closed_at,
          :attendees_count, :contributions_count, :attending_organizations, :address
        ]

        mirrored_attributes = mirrored_keys.inject({}) do |result, attribute|
          result.update(attribute => meeting_data.fetch(attribute.to_s))
        end

        meeting = Decidim::Meetings::Meeting.create!(
          mirrored_attributes.merge(
            id: meeting_data.fetch("id"),
            title: Importer.fake_i18n(meeting_data.fetch("title")),
            description: Importer.fake_i18n("<p>#{meeting_data.fetch("short_description")}</p>"),
            location: Importer.fake_i18n(meeting_data.fetch("location")),
            closing_report: Importer.fake_i18n(meeting_data.fetch("closing_report")),
            category: Importer.category_from(
              meeting_data.fetch("category_id"),
              meeting_data.fetch("subcategory_id")
            ),
            scope: scope,
            component: component,
            created_at: meeting_data.fetch("created_at"),
            updated_at: meeting_data.fetch("updated_at"),
            extra: meeting_data.fetch("extra")
          )
        )

        meeting.link_resources(
          Decidim::Proposals::Proposal.where(id: meeting_data.fetch("related_proposal_ids")),
          "proposals_from_meeting"
        )

        progress_bar.increment
      end

      Importer.fix_auto_increment("decidim_meetings_meetings")
    end
  end

  def create_meetings_component(process)
    component = Decidim::Component.find_or_initialize_by(
      manifest_name: "meetings",
      participatory_process: process
    )

    unless component.persisted?
      component.name = { ca: "Cites presencials", es: "Cites presenciales"}
      component.save!
    end

    component
  end
end
