# frozen_string_literal: true
# This migration comes from decidim_proposals (originally 20180613151121)

class CreateCollaborativeDraftCollaboratorRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :decidim_proposals_collaborative_draft_collaborator_requests do |t|
      t.belongs_to :decidim_proposals_collaborative_draft, null: false, index: { name: "index_collab_requests_on_decidim_proposals_collab_draft_id" }
      t.belongs_to :decidim_user, null: false, index: { name: "index_collab_requests_on_decidim_user_id" }

      t.timestamps
    end
  end
end
