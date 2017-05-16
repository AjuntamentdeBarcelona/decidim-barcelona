namespace :migrate do
  desc "Copy results from Decidim::Results feature to Decidim::Accountability feature for process (default 1 - PAM)"
  task :results_to_accountability, [:process_id] => :environment do |task, args|

    process_id = args.process_id.presence || 1

    process = Decidim::ParticipatoryProcess.find(process_id)
    unless process.present?
      puts "Process #{args.process_id} not found"
      next
    end

    results_feature = process.features.where(manifest_name: 'results').first
    unless results_feature.present?
      puts "Results feature not found for process"
      next
    end

    accountability_feature = process.features.where(manifest_name: 'accountability').first
    unless accountability_feature.present?
      puts "Accountability feature not found for process"
      next
    end

    # Copy results maintaining original record id
    Decidim::Results::Result.where(feature: results_feature).find_each do |result|
      accountability_result = Decidim::Accountability::Result.create!(
        id: result.id,
        feature: accountability_feature,
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
