# frozen_string_literal: true
# This migration comes from decidim_proposals (originally 20210318082934)

class FixCountersForCopiedProposals < ActiveRecord::Migration[5.2]
  def up
    copies_ids = Decidim::ResourceLink.where(
      name: "copied_from_component",
      from_type: "Decidim::Proposals::Proposal",
      to_type: "Decidim::Proposals::Proposal"
    ).pluck(:to_id)

    Decidim::Proposals::Proposal.where(id: copies_ids).find_each do |record|
      record.class.reset_counters(record.id, :follows)
      record.update_comments_count
    end
  end

  def down; end
end
