# frozen_string_literal: true
# This migration comes from decidim_proposals (originally 20200306123652)

class PublishExistingProposalsState < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL.squish
      UPDATE decidim_proposals_proposals SET state_published_at = COALESCE(answered_at, published_at) WHERE state IS NOT NULL
    SQL
  end

  def down
    execute <<-SQL.squish
      UPDATE decidim_proposals_proposals SET state_published_at = NULL
    SQL
  end
end
