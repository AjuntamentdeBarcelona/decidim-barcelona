# frozen_string_literal: true
# This migration comes from decidim_proposals (originally 20200915151348)

class FixProposalsDataToEnsureTitleAndBodyAreHashes3 < ActiveRecord::Migration[5.2]
  def up
    reset_column_information

    PaperTrail.request(enabled: false) do
      ActiveRecord::Base.uncached do

        idx= 0
        Decidim::Proposals::Proposal.where("id > ? AND id <= ?", 10_000, 15_000).find_each do |proposal|
          next if proposal.title.is_a?(Hash) && proposal.body.is_a?(Hash)
          process_proposal(proposal)
          print "proposal: #{proposal.id}//"
          idx+= 1
          GC.start && puts("\nPROCESSED: #{idx}") if idx%500 == 0
        end
        puts("\nPROCESSED: #{idx}")
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
