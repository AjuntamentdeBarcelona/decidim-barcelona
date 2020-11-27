# frozen_string_literal: true
# This migration comes from decidim_proposals (originally 20200915151348)

class FixProposalsDataToEnsureTitleAndBodyAreHashes < ActiveRecord::Migration[5.2]
  def up
    reset_column_information

    PaperTrail.request(enabled: false) do
      ActiveRecord::Base.uncached do

        Decidim::Proposals::Proposal.where("id <= ?", 5_000).find_each do |proposal|
          next if proposal.title.is_a?(Hash) && proposal.body.is_a?(Hash)
          process_proposal(proposal)
        end
        GC.start

        Decidim::Proposals::Proposal.where("id > ? AND id <= ?", 5_000, 10_000).find_each do |proposal|
          next if proposal.title.is_a?(Hash) && proposal.body.is_a?(Hash)
          process_proposal(proposal)
        end
        GC.start

        Decidim::Proposals::Proposal.where("id > ? AND id <= ?", 10_000, 15_000).find_each do |proposal|
          next if proposal.title.is_a?(Hash) && proposal.body.is_a?(Hash)
          process_proposal(proposal)
        end
        GC.start

        Decidim::Proposals::Proposal.where("id > ? AND id <= ?", 15_000, 17_500).find_each do |proposal|
          next if proposal.title.is_a?(Hash) && proposal.body.is_a?(Hash)
          process_proposal(proposal)
        end
        GC.start

        Decidim::Proposals::Proposal.where("id > ? AND id <= ?", 17_500, 20_000).find_each do |proposal|
          next if proposal.title.is_a?(Hash) && proposal.body.is_a?(Hash)
          process_proposal(proposal)
        end
        GC.start

        Decidim::Proposals::Proposal.where("id > ?", 20_000).find_each do |proposal|
          next if proposal.title.is_a?(Hash) && proposal.body.is_a?(Hash)
          process_proposal(proposal)
        end
        GC.start
      end
    end

    reset_column_information
  end

  def down; end

  def process_proposal(proposal)
    author = proposal.coauthorships.first.author

    locale = author.try(:locale).presence || author.try(:default_locale).presence || author.try(:organization).try(:default_locale).presence

    proposal.title = {
      locale => proposal.title
    }
    proposal.body = {
      locale => proposal.body
    }

    proposal.save(validate: false)
  end

  def reset_column_information
    Decidim::User.reset_column_information
    Decidim::Coauthorship.reset_column_information
    Decidim::Proposals::Proposal.reset_column_information
    Decidim::Organization.reset_column_information
  end
end