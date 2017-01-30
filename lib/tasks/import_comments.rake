require "importer"

namespace :import do
  task :comments => :environment do
    data = Importer.read_file("comments")

    Decidim::Comments::CommentVote.delete_all
    Decidim::Comments::Comment.delete_all

    progress_bar = Importer.progress_bar("Comments", data.length)

    data.each do |comment_data|
      commentable = comment_data.fetch("decidim_commentable_type").constantize.where(
        id: comment_data.fetch("decidim_commentable_id")
      ).first

      next unless commentable

      create_comment(comment_data, commentable)

      progress_bar.increment
    end

    Importer.fix_auto_increment("decidim_scopes")
  end

  def create_comment(data, commentable)
    author = Decidim::User.find(data.fetch("decidim_author_id"))
    user_group = author.user_groups.verified.first

    comment = Decidim::Comments::Comment.new(
      commentable: commentable,
      author: author,
      user_group: user_group,
      body: data.fetch("body"),
      alignment: data.fetch("alignment").to_i,
      depth: data.fetch("depth"),
      created_at: data.fetch("created_at"),
      updated_at: data.fetch("updated_at")
    )

    comment.save!(validate: false)

    begin
      data.fetch("votes_up").map do |user_id|
        create_vote(comment, user_id, 1)
      end

      data.fetch("votes_down").map do |user_id|
        create_vote(comment, user_id, -1)
      end
    rescue ActiveRecord::RecordInvalid
      nil
    end

    data.fetch("replies").map do |reply|
      create_comment(reply, comment)
    end
  end

  def create_vote(comment, user_id, weight)
    user = Decidim::User.find(user_id)

    Decidim::Comments::CommentVote.create!(
      comment: comment,
      author: user,
      weight: weight
    )
  end
end
