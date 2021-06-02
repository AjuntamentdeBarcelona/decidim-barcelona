# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    module ConflictsControllerOverride
      extend ActiveSupport::Concern

      included do
        # TEMPORARY OVERRIDE TO RENDER FORM ON ERROR (BUG IN DECIDIM)
        # https://github.com/decidim/decidim/blob/00bad01ccfa95473fd2d7b2f2cb1919623295ba3/decidim-admin/app/controllers/decidim/admin/conflicts_controller.rb#L40
        def update
          conflict = Decidim::Verifications::Conflict.find(params[:id])

          @form = form(Decidim::Admin::TransferUserForm).from_params(
            current_user: current_user,
            conflict: conflict,
            reason: params[:transfer_user][:reason],
            email: params[:transfer_user][:email]
          )

          Decidim::Admin::TransferUser.call(@form) do
            on(:ok) do
              flash[:notice] = I18n.t("success", scope: "decidim.admin.conflicts.transfer")
              redirect_to conflicts_path
            end

            on(:invalid) do
              flash.now[:alert] = I18n.t("error", scope: "decidim.admin.conflicts.transfer")
              render :edit
            end
          end
        end
      end
    end
  end
end
