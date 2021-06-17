# frozen_string_literal: true

namespace :decidim do
  namespace :ephemeral_participation do
    desc "Purge verifications created but not used, to allow participants to try it again with another ephemeral User"
    task purge_unused_verifications: :environment do
      unused_autorizations.find_each do |authorization|
        conflicts_for(authorization.user).delete_all
        authorization.destroy!
      end
    end

    def unused_autorizations
      Decidim::Authorization
    end

    def conflicts_for(user)
      Decidim::Conflict.where(managed_user: user, solved: false).or(
        Decidim::Conflict.where(user: user, solved: false)
      )
    end
  end
end
