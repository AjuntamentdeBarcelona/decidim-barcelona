# frozen_string_literal: true

# This migration comes from decidim_debates (originally 20200902133452)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class AddCachedCommentMetadataToDebates < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_debates_debates, :last_comment_at, :datetime
    add_column :decidim_debates_debates, :last_comment_by_id, :integer
    add_column :decidim_debates_debates, :last_comment_by_type, :string

    # rubocop:disable Rails/SkipsModelValidations
    Decidim::Debates::Debate.reset_column_information
    Decidim::Debates::Debate.unscoped.includes(comments: [:author, :user_group]).find_each do |debate|
      last_comment = debate.comments.order("created_at DESC").first
      next unless last_comment

      debate.update_columns(
        last_comment_at: last_comment.created_at,
        last_comment_by_id: last_comment.decidim_author_id,
        last_comment_by_type: last_comment.decidim_author_type
      )
    end
    # rubocop:enable Rails/SkipsModelValidations
  end
end
