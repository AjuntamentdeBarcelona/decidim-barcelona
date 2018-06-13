require "importer"

namespace :import do
  task :debates => :environment do
    data = Importer.read_file("debates")

    ActiveRecord::Base.transaction do
      Decidim::Debates::Debate.delete_all
      Decidim::Component.where(manifest_name: "debates").delete_all

      progress_bar = Importer.progress_bar("Debates", data.length)

      data.each do |debate_data|
        process = Decidim::ParticipatoryProcess.where(id: debate_data.delete("process_id")).first
        component = create_debates_component(process)

        Decidim::Debates::Debate.create!(
          id: debate_data.fetch("id"),
          title: Importer.fake_i18n(debate_data.fetch("title")),
          description: Importer.fake_i18n(debate_data.fetch("description")),
          instructions: Importer.fake_i18n(debate_data.fetch("instructions")),
          start_time: debate_data.fetch("start_time"),
          end_time: debate_data.fetch("end_time"),
          created_at: debate_data.fetch("created_at"),
          updated_at: debate_data.fetch("updated_at"),
          component: component,
          extra: debate_data.fetch("extra")
        )

        progress_bar.increment
      end

      Importer.fix_auto_increment("decidim_debates_debates")
    end
  end

  def create_debates_component(process)
    component = Decidim::Component.find_or_initialize_by(
      manifest_name: "debates",
      participatory_process: process
    )

    component["settings"] = {
      global: {
        comments_always_enabled: true
      }
    }

    unless component.persisted?
      component.name = { ca: "Debats", es: "Debates"}
      component.save!
    end

    component
  end
end
