# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    module NeedsPermissionOverride
      extend ActiveSupport::Concern

      included do
        alias_method :old_user_has_no_permission, :user_has_no_permission
        alias_method :old_permissions_context, :permissions_context

        def user_has_no_permission
          if request.xhr?
            new_user_has_no_permission
          else
            old_user_has_no_permission
          end
        end

        def permissions_context
          old_permissions_context.merge(request: request)
        end

        private

        def new_user_has_no_permission
          render(js: unauthorized_error_flash_message_js)
        end

        def unauthorized_error_flash_message_js
          <<~JAVASCRIPT
            $alertBoxParsedHtml = $.parseHTML('#{unauthorized_error_flash_message_html}')[0].outerHTML;
            alertBoxNotFound    = $('#content').html().indexOf($alertBoxParsedHtml) == -1;

            if (alertBoxNotFound) $('#content').prepend($alertBoxParsedHtml);

            $(window).scrollTop(0);
          JAVASCRIPT
        end

        def unauthorized_error_flash_message_html
          flash.clear

          flash.now[:alert] = unauthorized_message

          helpers.display_flash_messages
        end

        def unauthorized_message
          if current_user && current_user.ephemeral_participant?
            unauthorized_ephemeral_participant_message
          else
            I18n.t("actions.unauthorized", scope: "decidim.core")
          end
        end

        def unauthorized_ephemeral_participant_message
          presenter = Decidim::EphemeralParticipation::FlashMessagesPresenter.new(current_user, helpers)

          if current_user.verified_ephemeral_participant?
            presenter.unauthorized_ephemeral_participant_message
          else
            presenter.unverified_ephemeral_participant_message
          end
        end
      end
    end
  end
end
