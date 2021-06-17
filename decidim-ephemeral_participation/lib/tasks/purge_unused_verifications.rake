# frozen_string_literal: true

namespace :decidim do
  namespace :ephemeral_participation do
    desc "Purge verifications created but not used, to allow participants to try it again with another ephemeral User"
    task purge_unused_verifications: :environment do
      puts "Deleting #{unused_autorizations.count} authorizations... "

      conflicts = 0
      unused_autorizations.find_each do |authorization|
        conflicts += conflicts_for(authorization.user).delete_all
        authorization.destroy!
      end
      puts "and #{conflicts} related conflicts.\n"
    end

    def unused_autorizations
      Decidim::Authorization.where(user: lost_ephemeral_users)
    end

    def lost_ephemeral_users
      Decidim::User.ephemeral_participant.where("updated_at < ?", 12.hours.ago).where("id NOT IN (SELECT decidim_user_id FROM decidim_budgets_orders)")
    end

    def conflicts_for(user)
      Decidim::Conflict.where(managed_user: user, solved: false).or(
        Decidim::Conflict.where(current_user: user, solved: false)
      )
    end
  end
end
