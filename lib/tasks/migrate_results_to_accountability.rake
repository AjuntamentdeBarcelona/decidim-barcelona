# frozen_string_literal: true

namespace :migrate do
  desc "Copy results from Decidim::Results component to Decidim::Accountability component for process (default 1 - PAM)"
  task :results_to_accountability, [:process_id] => :environment do |_, args|
    process_id = args.process_id.presence || 1

    process = Decidim::ParticipatoryProcess.find_by(id: process_id)
    abort "Process #{process_id} not found" unless process.present?

    results_component = process.components.where(manifest_name: "results").first
    abort "Results component not found for process" unless results_component.present?

    accountability_component = process.components.where(manifest_name: "accountability").first
    abort "Accountability component not found for process" unless accountability_component.present?

    # Copy results maintaining original record id
    Decidim::Results::Result.where(component: results_component).find_each do |result|
      accountability_result = Decidim::Accountability::Result.create!(
        id: result.id,
        component: accountability_component,
        scope: result.scope,
        category: result.category,
        title: result.title,
        description: result.description
      )

      proposals = result.linked_resources(:proposals, "included_proposals")
      accountability_result.link_resources(proposals, "included_proposals")

      meeting_ids = proposals.flat_map do |proposal|
        proposal.linked_resources(:meetings, "proposals_from_meeting").pluck(:id)
      end.uniq
      meetings = accountability_result.sibling_scope(:meetings).where(id: meeting_ids)
      accountability_result.link_resources(meetings, "meetings_through_proposals")
    end
  end
end
