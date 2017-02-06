require "importer"

namespace :import do
  task :processes => :environment do
    ActiveRecord::Base.transaction do
      data = Importer.read_file("processes")

      Decidim::ParticipatoryProcessStep.delete_all
      Decidim::ParticipatoryProcess.delete_all

      progress_bar = Importer.progress_bar("Processes", data.length)
      organization = Decidim::Organization.first

      data.each do |process_data|
        process = Decidim::ParticipatoryProcess.new(
          id: process_data.fetch("id"),
          slug: process_data.fetch("slug"),
          organization: organization,
          hashtag: process_data.fetch("hashtag"),
          created_at: process_data.fetch("created_at"),
          updated_at: process_data.fetch("updated_at"),
          title: process_data.fetch("title"),
          subtitle: process_data.fetch("subtitle"),
          short_description: process_data.fetch("short_description"),
          description: process_data.fetch("description"),
          remote_hero_image_url: process_data.fetch("hero_image"),
          remote_banner_image_url: process_data.fetch("banner_image"),
          promoted: process_data.fetch("promoted"),
          published_at: process_data.fetch("published_at"),
          scope: Importer.fake_i18n(process_data.fetch("scope")),
          developer_group: process_data.fetch("developer_group"),
          local_area: Importer.fake_i18n(process_data.fetch("domain")),
          target: Importer.fake_i18n(process_data.fetch("extra").fetch("audience")),
          participatory_scope: Importer.fake_i18n(process_data.fetch("extra").fetch("citizenship_scope")),
          participatory_structure: Importer.fake_i18n(process_data.fetch("extra").fetch("participatory_structure")),
          extra: {
            scope_id: process_data.fetch("scope_id")
          }.merge(process_data.fetch("extra"))
        )

        process.save!(validate: false)

        process_data["steps"].each do |step|
          step = Decidim::ParticipatoryProcessStep.new(
            participatory_process: process,
            id: step.fetch("id"),
            title: step.fetch("title"),
            description: step.fetch("description"),
            start_date: step.fetch("start_at"),
            end_date: step.fetch("end_at"),
            position: step.fetch("position"),
            active: step.fetch("active"),
            created_at: step.fetch("created_at"),
            updated_at: step.fetch("updated_at"),
            short_description: step.fetch("summary"),
            extra: step.fetch("extra")
          )

          step.save!(validate: false)
        end

        progress_bar.increment
      end

      Importer.fix_auto_increment("decidim_participatory_processes")
    end
  end
end
