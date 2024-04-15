# frozen_string_literal: true

module Decidim
  module Proposals
    module ApplicationHelperOverride
      extend ActiveSupport::Concern

      included do
        def safe_content_admin?
          ((@proposal.official? || @proposal.official_meeting?) && not_from_participatory_text(@proposal)) || safe_content_allowed_user?
        end

        private

        def safe_content_allowed_user?
          @proposal.authored_by?(safe_content_allowed_users)
        end

        def safe_content_allowed_users
          @safe_content_allowed_users ||= Decidim::User.where(id: ENV.fetch("PROPOSAL_SAFE_CONTENT_ALLOWED_USERS", "").split(","))
        end
      end
    end
  end
end
