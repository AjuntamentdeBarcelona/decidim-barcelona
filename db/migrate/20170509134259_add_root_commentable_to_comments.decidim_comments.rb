# This migration comes from decidim_comments (originally 20170504085413)
class AddRootCommentableToComments < ActiveRecord::Migration[5.0]
  def root_commentable(comment)
    return comment.commentable if comment.depth.zero?
    root_commentable comment.commentable
  end

  def change
    change_table :decidim_comments_comments do |t|
      t.references :decidim_root_commentable, polymorphic: true, index: { name: "decidim_comments_comment_root_commentable" }
    end
  end
end
