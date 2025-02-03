# frozen_string_literal: true

namespace :decidim do
  desc "Modify nicknames removing invalid characters"
  task sanitize_nicknames: :environment do
    logger = Logger.new($stdout)
    logger.info("Sanitizing invalid user nicknames...")

    updated_nicknames_count = 0
    errors_updating_nickname = 0
    Decidim::User.not_deleted.each do |user|
      next unless (user.nickname =~ Decidim::User::REGEXP_NICKNAME).nil?

      original_nickname = user.nickname
      nickname = I18n.transliterate(user.nickname).gsub(/[^[\w-]]/, "")
      begin
        user.update!(nickname:)
        logger.info("User ID (#{user.id}) : Invalid nickname #{user.nickname}. Changing it to: #{nickname}")
        updated_nicknames_count += 1
      rescue ActiveRecord::RecordInvalid => e
        logger.warn("User ID (#{user.id}) : #{e} (original nickname: #{original_nickname})")
        errors_updating_nickname += 1
      end
    end
    logger.info("Process terminated, #{updated_nicknames_count} users nickname have been updated. #{errors_updating_nickname} errors occurred.")
  end
end
