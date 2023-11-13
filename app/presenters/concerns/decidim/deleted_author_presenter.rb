# frozen_string_literal: true

module Decidim
  #
  # A dummy presenter to abstract out a deleted author.
  #
  class DeletedAuthorPresenter < Decidim::OfficialAuthorPresenter
    def name
      I18n.t("decidim.profile.deleted")
    end
  end
end
