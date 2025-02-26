# frozen_string_literal: true

namespace :decidim do
  desc "Change authors from merged proposal using the authors from the origin proposals and removing the organization one"
  task :change_merged_proposal_authors, [:proposal_id] => :environment do |_task, args|
    target_proposal = Decidim::Proposals::Proposal.find(args.proposal_id)
    origin_proposals = target_proposal.linked_resources(:proposals, %w(splitted_from_component merged_from_component copied_from_component))
    abort("[KO] No origin proposals found for the proposal given") if origin_proposals.empty?

    authors = origin_proposals.map(&:authors).flatten.uniq
    abort("[KO] The origin proposal don't have authors") if origin_proposals.empty?

    authors.each do |author|
      next if target_proposal.authors.include?(author)

      target_proposal.add_coauthor(author)
    end
    target_proposal.coauthorships.where(decidim_author_type: "Decidim::Organization").destroy_all

    puts "[OK] Authors from origin proposals added to the target proposal"
  rescue StandardError => e
    puts "[KO] An error occurred: #{e.message}"
  end
end
