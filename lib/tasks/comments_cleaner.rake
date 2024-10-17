# frozen_string_literal: true

namespace :comments_cleaner do
  desc "Destroy comments with nil commentable or author"
  task clean: :environment do
    log = ActiveSupport::Logger.new(Rails.root.join("log/comments_cleaner-clean.log"))
    Decidim::Comments::Comment.all.select { |comment| comment.commentable.nil? || comment.author.nil? }.each do |comment|
      p "Comment ##{comment.id} successfully destroyed" if comment.destroy
    rescue StandardError => e
      log.error "Error removing comment ##{comment.id}: #{e.message}"
    end
  end
end
