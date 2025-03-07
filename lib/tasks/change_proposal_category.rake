# frozen_string_literal: true

namespace :decidim do
  desc "Change proposal category"
  task :change_proposal_category, [:proposal_id, :category_id] => :environment do |_task, args|
    proposal = Decidim::Proposals::Proposal.find(args.proposal_id)
    category = Decidim::Category.find(args.category_id)
    raise StandardError, "Proposal #{proposal.id} already has the category given" if proposal.category == category

    proposal.update(category:)

    puts "[OK] Proposal category updated"
  rescue StandardError => e
    puts "[KO] An error occurred: #{e.message}"
  end
end
