require "importer"

namespace :import do
  task :proposals => :environment do
    data = Importer.read_file("proposals")

    ActiveRecord::Base.transaction do
      Decidim::Proposals::Proposal.delete_all
      Decidim::Feature.where(manifest_name: "proposals").delete_all

      progress_bar = Importer.progress_bar("Proposals", data.length)

      data.each do |proposal_data|
        process = Decidim::ParticipatoryProcess.where(id: proposal_data.fetch("process_id")).first
        next unless process

        feature = create_feature(process)

        author = Decidim::User.find(proposal_data.fetch("author_id"))
        user_group = author.user_groups.verified.first

        scope = Decidim::Scope.where(id: proposal_data.fetch("scope_id")).first

        Decidim::Proposals::Proposal.create!(
          id: proposal_data.fetch("id"),
          author: (proposal_data.dig("extra", "official") ? nil : author),
          user_group: user_group,
          category: Importer.category_from(
            proposal_data.fetch("category_id"),
            proposal_data.fetch("subcategory_id")
          ),
          scope: scope,
          feature: feature,
          title: proposal_data.fetch("title"),
          body: proposal_data.fetch("body"),
          created_at: proposal_data.fetch("created_at"),
          updated_at: proposal_data.fetch("updated_at"),
          answer: {
            ca: proposal_data.fetch("answer"),
            es: proposal_data.fetch("answer")
          },
          state: proposal_data.fetch("state"),
          answered_at: proposal_data.fetch("answered_at"),
          extra: proposal_data.fetch("extra")
        )

        progress_bar.increment
      end

      Importer.fix_auto_increment("decidim_proposals_proposals")
    end
  end

  def create_feature(process)
    feature = Decidim::Feature.find_or_initialize_by(
      manifest_name: "proposals",
      participatory_process: process
    )

    return feature if feature.persisted?

    global_settings = {}

    step_settings = process.steps.inject({}) do |result, step|
      flags = step.extra["flags"]
      settings = {}

      if step.extra["proposal_vote_limit"].to_i.positive?
        global_settings["vote_limit"] ||= step.extra["proposal_vote_limit"].to_i
      end

      settings["votes_enabled"] = true
      settings["votes_blocked"] = !flags.include?("enable_proposal_votes")
      settings["comments_enabled"] = flags.include?("enable_proposal_comments")
      settings["creation_enabled"] = flags.include?("enable_proposal_creation")

      result.update(step.id.to_s => settings)
    end

    feature.name = { ca: "Propostes", es: "Propuestas"}

    feature["settings"] = {
      global: global_settings,
      steps: step_settings
    }

    feature.save!
    feature
  end
end
