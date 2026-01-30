# frozen_string_literal: true

# This migration comes from decidim_comments (originally 20170510091348)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class UpdateRootCommentableForComments < ActiveRecord::Migration[5.0]
  def up
    # rubocop:disable Rails/SkipsModelValidations
    Decidim::Comments::Comment.where(depth: 0).update_all(
      "decidim_root_commentable_id = decidim_commentable_id, decidim_root_commentable_type = decidim_commentable_type"
    )
    # rubocop:enable Rails/SkipsModelValidations

    Decidim::Comments::Comment.where("depth > 0").find_each do |comment|
      comment.root_commentable = root_commentable(comment)
      comment.save(validate: false)
    end
  end

  def down; end

  private

  def root_commentable(comment)
    return comment.commentable if comment.depth.zero?

    root_commentable comment.commentable
  end
end
