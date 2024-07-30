# frozen_string_literal: true

module Decidim
  module Admin
    module ConflictsControllerOverride
      extend ActiveSupport::Concern

      included do
        def index
          enforce_permission_to :index, :impersonatable_user

          @conflicts = Decidim::Verifications::Conflict.joins(:current_user).where(
            decidim_users: { decidim_organization_id: current_organization.id, deleted_at: nil }
          )
        end
      end
    end
  end
end
