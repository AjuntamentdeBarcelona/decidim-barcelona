# frozen_string_literal: true

module Decidim
  module System
    module BaseOrganizationFormOverride
      extend ActiveSupport::Concern

      included do
        def validate_secret_key_base_for_encryption
          return if Rails.application.secret_key_base&.length == 64

          errors.add(:password, I18n.t("activemodel.errors.models.organization.attributes.password.secret_key"))
        end
      end
    end
  end
end
