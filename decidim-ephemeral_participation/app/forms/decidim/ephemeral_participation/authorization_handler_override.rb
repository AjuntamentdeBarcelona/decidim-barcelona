# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    module AuthorizationHandlerOverride
      extend ActiveSupport::Concern

      included do
        alias_method :old_uniqueness, :uniqueness

        private

        def uniqueness
          return true if unique_id.nil? || duplicates.none?

          errors.add(:base, uniqueness_error)

          false
        end

        def uniqueness_error
          if user.ephemeral_participant?
            ActionController::Base.new.render_to_string(partial: "decidim/ephemeral_participation/ephemeral_participants/existing_verification_msg", locals: { user: user })
          else
            I18n.t("decidim.authorization_handlers.errors.duplicate_authorization")
          end
        end
      end
    end
  end
end
