# frozen_string_literal: true

module Decidim
  module UserProfileCellOverride
    extend ActiveSupport::Concern

    included do
      def resource_path
        return "#" if user.nickname.blank?

        decidim.profile_path(user.nickname)
      end
    end
  end
end
