# frozen_string_literal: true

module Decidim
  module Initiatives
    module Admin
      module PermissionsOverride
        extend ActiveSupport::Concern

        def initiative_admin_user_action?
          return unless permission_action.subject == :initiative

          case permission_action.action
          when :read
            toggle_allow(Decidim::Initiatives.print_enabled)
          when :publish, :discard
            toggle_allow(initiative.validating?)
          when :unpublish
            toggle_allow(initiative.published?)
          when :export_pdf_signatures
            toggle_allow(initiative.published? || initiative.accepted? || initiative.rejected?)
          when :export_votes
            toggle_allow(true)
          when :accept
            allowed = initiative.published? &&
                      initiative.signature_end_date < Date.current &&
                      initiative.supports_goal_reached?
            toggle_allow(allowed)
          when :reject
            allowed = initiative.published? &&
                      initiative.signature_end_date < Date.current &&
                      !initiative.supports_goal_reached?
            toggle_allow(allowed)
          when :send_to_technical_validation
            toggle_allow(allowed_to_send_to_technical_validation?)
          else
            allow!
          end
        end
      end
    end
  end
end
