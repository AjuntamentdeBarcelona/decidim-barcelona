require "importer"

namespace :import do
  task :user_groups => :environment do
    ActiveRecord::Base.transaction do
      data = Importer.read_file("user_groups")
      Decidim::UserGroup.delete_all
      Decidim::UserGroupMembership.delete_all

      progress_bar = Importer.progress_bar("User groups", data.length)

      data.each do |user_group_data|
        user = Decidim::User.find(user_group_data["user_id"])

        user_group = Decidim::UserGroup.new(
          name: user_group_data.fetch("name"),
          document_number: user_group_data.fetch("document_number").presence || "-",
          phone: user.extra["phone_number"],
          verified_at: user_group_data.fetch("verified_at")
        )

        user_group.save!(validate: false)

        Decidim::UserGroupMembership.create!(
          user: user,
          user_group: user_group
        )

        progress_bar.increment
      end

      Importer.fix_auto_increment("decidim_user_groups")
    end
  end
end
