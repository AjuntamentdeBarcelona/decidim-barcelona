# frozen_string_literal: true

module Decidim
  #
  # A dummy presenter to abstract out a deleted author.
  #
  class DeletedAuthorPresenter < Decidim::OfficialAuthorPresenter
    def name
      I18n.t("decidim.profile.deleted")
    end

    def avatar_url(_variant = nil)
      ActionController::Base.helpers.asset_pack_path("media/images/default-avatar.svg")
    end
  end
end
