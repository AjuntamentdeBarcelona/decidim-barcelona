# frozen_string_literal: true

module Decidim
  module Proposals
    module ProposalPresenterOverride
      extend ActiveSupport::Concern

      included do
        def author
          @author ||= if official?
                        Decidim::Proposals::OfficialAuthorPresenter.new
                      else
                        coauthorships.includes(:author).first.author.presenter
                        return coauthorship.user_group.presenter if coauthorship&.user_group
                        return coauthorship.author.presenter if coauthorship&.author

                        Decidim::DeletedAuthorPresenter.new
                      end
        end
      end
    end
  end
end
