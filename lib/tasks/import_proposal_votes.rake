require "importer"

namespace :import do
  task :proposal_votes => :environment do
    data = Importer.read_file("proposal_votes")

    Decidim::Proposals::ProposalVote.delete_all

    user_ids = data.map do |vote|
      vote.fetch("user_id")
    end.uniq

    proposal_ids = data.map do |vote|
      vote.fetch("proposal_id")
    end.uniq

    users = Decidim::User.where(id: user_ids).includes(:organization).load
    proposals = Decidim::Proposals::Proposal.where(id: proposal_ids).includes(:organization).load

    progress_bar = Importer.progress_bar("Proposal votes", data.length)

    data.each do |vote|
      begin
        ActiveRecord::Base.connection.execute("INSERT INTO decidim_proposals_proposal_votes (decidim_proposal_id, decidim_author_id, created_at, updated_at) VALUES (#{vote.fetch("proposal_id")}, #{vote.fetch("user_id")}, '#{vote.fetch("created_at")}', '#{vote.fetch("created_at")}')")

        progress_bar.increment
      rescue => e
        proposal = proposals.find { |p| p.id == vote.fetch("proposal_id") }
        user = users.find { |u| u.id == vote.fetch("user_id") }

        raise e if Decidim::Proposals::ProposalVote.where(
             decidim_proposal_id: vote.fetch("proposal_id"),
             decidim_author_id: vote.fetch("user_id")
           ).count == 0 && (proposal && user)
      end
    end

    progress_bar = Importer.progress_bar("Proposal counters", proposals.length)
    proposals.each do |p|
      Decidim::Proposals::Proposal.reset_counters p.id, :votes
      progress_bar.increment
    end

    Importer.fix_auto_increment("decidim_proposals_proposal_votes")
  end
end
